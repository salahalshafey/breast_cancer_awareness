// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../../../core/error/exceptions.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/util/builders/custom_alret_dialoge.dart';

class PasswordResetForm extends StatefulWidget {
  const PasswordResetForm({super.key});

  @override
  State<PasswordResetForm> createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends State<PasswordResetForm> {
  final _formKey = GlobalKey<FormState>();
  final _focusNodeForEmail = FocusNode();

  var _userEmail = '';
  String? _apiErrorForEmail;
  bool _isLoading = false;
  bool _isEmailFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNodeForEmail.addListener(() {
      setState(() {
        _isEmailFocused = _focusNodeForEmail.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNodeForEmail.dispose();

    super.dispose();
  }

  void _isLoadingState(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  void _sendResetRequest() async {
    ////////// we are sending new request so, we should setting api errors to null /////////////
    setState(() {
      _apiErrorForEmail = null;
    });

    ///////// Validate all Fields /////////
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      _focusNodeForEmail.requestFocus();
      return;
    }

    ///////// Save the data from textFields /////////
    _formKey.currentState!.save();

    try {
      _isLoadingState(true);

      if (await NetworkInfoImpl().isNotConnected) {
        throw Error("You are currently offline.");
      }

      await FirebaseAuth.instance.sendPasswordResetEmail(email: _userEmail);
    } on FirebaseAuthException catch (e) {
      _isLoadingState(false);

      if (e.code == 'user-not-found' || e.code == 'invalid-email') {
        setState(() {
          _apiErrorForEmail = "No user found for that email";
        });
        _formKey.currentState!.validate();
        _focusNodeForEmail.requestFocus();
      } else {
        showCustomAlretDialog(
          context: context,
          title: 'ERROR',
          titleColor: Colors.red,
          content: e.code,
        );
      }

      return;
    } catch (error) {
      _isLoadingState(false);

      showCustomAlretDialog(
        context: context,
        title: 'ERROR',
        titleColor: Colors.red,
        content: error.toString(),
      );

      return;
    }

    _isLoadingState(false);

    final titleColor = Theme.of(context).appBarTheme.foregroundColor;
    showCustomAlretDialog(
      context: context,
      constraints: const BoxConstraints(maxWidth: 500),
      barrierDismissible: false,
      canPopScope: false,
      title: 'Follow up',
      titleColor: titleColor,
      icon: Icon(Icons.info, color: titleColor, size: 45),
      content:
          "* Check your **inbox** for an email that has just been sent for your $_userEmail.\n"
          "* Follow the **link** and reset your password.\n"
          "* When you **finish**, return to the app and sign in with the new password.",
      actionsBuilder: (dialogContext) => [
        TextButton(
          onPressed: (() {
            Navigator.of(dialogContext).pop();
            Navigator.of(dialogContext).pop();
          }),
          child: Text(
            "Finished resetting",
            style: TextStyle(color: titleColor),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final focusColor = Theme.of(context).primaryColor;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            key: const ValueKey('email'),
            focusNode: _focusNodeForEmail,
            autocorrect: false,
            enableSuggestions: false,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
            inputFormatters: [FilteringTextInputFormatter.deny(" ")],
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Email',
              fillColor: _isEmailFocused ? focusColor : null,
            ),
            onTapOutside: (_) {
              _focusNodeForEmail.unfocus();
            },
            onFieldSubmitted: (value) {
              _sendResetRequest();
            },
            validator: (value) {
              // if all the value is email
              final emailMatcher =
                  RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$");
              if (value == null || !emailMatcher.hasMatch(value)) {
                return 'Please enter a valid email address.';
              }

              return _apiErrorForEmail;
            },
            onSaved: (value) {
              _userEmail = value!.trim();
            },
          ),
          const SizedBox(height: 30),
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: _sendResetRequest,
                  style: const ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(
                        Size.fromWidth(double.maxFinite)),
                  ),
                  child: const Text("Send Reset Request"),
                ),
        ],
      ),
    );
  }
}
