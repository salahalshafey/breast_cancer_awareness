// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/util/builders/custom_alret_dialog.dart';
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
  final _focusNodeForPassword = FocusNode();

  var _userPassword = '';
  String? _apiErrorForPassword;
  bool _isLoading = false;

  bool _isPasswordIconShowen = false;
  bool _isPasswordShowen = false;

  void _setLoadingState(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  Future<void> _saveFormAndReauthenticate() async {
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
    const borderColor = Colors.red;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            key: const ValueKey('password'),
            focusNode: _focusNodeForPassword,
            obscureText: _isPasswordShowen ? false : true,
            style: const TextStyle(fontSize: 20),
            autofocus: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.password,
              hintStyle: const TextStyle(),
              errorMaxLines: 2,
              fillColor: Colors.transparent,
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
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(22),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(22),
              ),
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
            onFieldSubmitted: (value) {
              _saveFormAndReauthenticate();
            },
            validator: (value) {
              if (value == null || value.trim().length < 8) {
                return AppLocalizations.of(context)!.passwordMustBeAtLeast;
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
                onPressed: _isLoading ? null : _saveFormAndReauthenticate,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.red.shade900),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.delete,
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
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
            ],
          )
        ],
      ),
    );
  }
}
