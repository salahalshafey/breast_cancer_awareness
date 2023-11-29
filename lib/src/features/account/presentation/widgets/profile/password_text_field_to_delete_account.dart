// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/util/builders/custom_alret_dialoge.dart';
import '../../providers/account.dart';

class PasswordTextFieldToDeleteAccount extends StatefulWidget {
  const PasswordTextFieldToDeleteAccount({super.key});

  @override
  State<PasswordTextFieldToDeleteAccount> createState() =>
      _PasswordTextFieldToDeleteAccountState();
}

class _PasswordTextFieldToDeleteAccountState
    extends State<PasswordTextFieldToDeleteAccount> {
  final _formKey = GlobalKey<FormState>();

  var _userPassword = '';

  String? _apiErrorForPassword;

  bool _isLoading = false;

  final _focusNodeForPassword = FocusNode();
  bool _isPasswordFocused = false;

  bool _isPasswordIconShowen = false;
  bool _isPasswordShowen = false;

  @override
  void initState() {
    super.initState();

    _focusNodeForPassword.addListener(() {
      setState(() {
        _isPasswordFocused = _focusNodeForPassword.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNodeForPassword.dispose();
    super.dispose();
  }

  void _setLoadingState(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  Future<void> _saveForm() async {
    ////////// we are sending new request so, we should setting api errors to null /////////////
    setState(() {
      _apiErrorForPassword = null;
    });

    ///////// Validate the Field /////////
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      _focusNodeForPassword.requestFocus();
      return;
    }

    ///////// Save the data from textField /////////
    _formKey.currentState!.save();

    ///////// reauthenticate And handle the errors and loading /////////
    final account = Provider.of<Account>(context, listen: false);
    try {
      _setLoadingState(true);

      await account.reauthenticateWithPasswordCredential(_userPassword);
      Navigator.of(context).pop(true);
    } catch (error) {
      _setLoadingState(false);

      // if the error on any textField show that error on the validator
      // if not, for example you are offline, show it to alret dialoge
      if (error.toString() == "The password is wrong.") {
        setState(() {
          _apiErrorForPassword = error.toString();
        });

        _formKey.currentState!.validate();
        _focusNodeForPassword.requestFocus();
      } else {
        showCustomAlretDialog(
          context: context,
          title: 'ERROR',
          titleColor: Colors.red,
          content: '$error',
        );
      }
    }
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
            key: const ValueKey('password'),
            focusNode: _focusNodeForPassword,
            obscureText: _isPasswordShowen ? false : true,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            // textAlign: TextAlign.center,
            autofocus: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              hintText: 'Password',
              errorMaxLines: 2,
              fillColor: _isPasswordFocused ? focusColor : null,
              suffixIconColor: Colors.white,
              suffixIcon: _isPasswordIconShowen
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordShowen = !_isPasswordShowen;
                        });
                      },
                      child: Icon(
                        _isPasswordShowen
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye,
                      ),
                    )
                  : null,
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  _isPasswordIconShowen = true;
                });
              } else {
                setState(() {
                  _isPasswordIconShowen = false;
                  _isPasswordShowen = false;
                });
              }
            },
            onTapOutside: (_) {
              _focusNodeForPassword.unfocus();
            },
            onFieldSubmitted: (value) {
              _saveForm();
            },
            validator: (value) {
              if (value == null || value.trim().length < 8) {
                return 'Password must be at least 8 characters long.';
              }

              return _apiErrorForPassword;
            },
            onSaved: (value) {
              _userPassword = value!;
            },
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _isLoading ? null : _saveForm,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.red.shade900),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      "Delete",
                      style: TextStyle(
                        color: _isLoading ? Colors.transparent : null,
                      ),
                    ),
                    if (_isLoading)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3.0,
                        ),
                      )
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStatePropertyAll(Colors.red.shade900),
                  side: MaterialStatePropertyAll(
                      BorderSide(color: Colors.red.shade900)),
                ),
                child: const Text("Cancel"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
