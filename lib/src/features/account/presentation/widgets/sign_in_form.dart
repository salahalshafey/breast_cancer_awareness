// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

import '../pages/send_password_reset_email_screen.dart';
import '../providers/account.dart';

import '../pages/first_sign_up_screen.dart';

import '../../../../core/util/builders/custom_alret_dialoge.dart';
import 'dont_or_already_have_accout.dart';
import 'sign_in_as_guest_button.dart';
import 'social_sign_in.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  var _userEmail = '';
  var _userPassword = '';

  String? _apiErrorForEmail;
  String? _apiErrorForPassword;

  var _isLoading = false;

  final _focusNodeForEmail = FocusNode();
  final _focusNodeForPassword = FocusNode();
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;

  bool _isPasswordIconShowen = false;
  bool _isPasswordShowen = false;

  @override
  void initState() {
    super.initState();
    _focusNodeForEmail.addListener(() {
      setState(() {
        _isEmailFocused = _focusNodeForEmail.hasFocus;
      });
    });

    _focusNodeForPassword.addListener(() {
      setState(() {
        _isPasswordFocused = _focusNodeForPassword.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNodeForEmail.dispose();
    _focusNodeForPassword.dispose();
    super.dispose();
  }

  void _isLoadingState(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  void _resetSignInState() {
    _formKey.currentState!.reset();
    setState(() {
      _isPasswordIconShowen = false;
      _isPasswordShowen = false;
      _isLoading = false;
      _apiErrorForEmail = null;
      _apiErrorForPassword = null;
    });
  }

  Future<void> _saveForm() async {
    ////////// we are sending new request so, we should setting api errors to null /////////////
    setState(() {
      _apiErrorForEmail = null;
      _apiErrorForPassword = null;
    });

    ///////// Validate all Fields /////////
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    ///////// Save the data from textFields /////////
    _formKey.currentState!.save();

    ///////// Login And handle the errors and loading /////////
    final account = Provider.of<Account>(context, listen: false);
    try {
      _isLoadingState(true);

      await account.signInUsingEmailAndPassword(_userEmail, _userPassword);
    } catch (error) {
      _isLoadingState(false);

      // if the error on any textField show that error on the validator
      // if not, for example you are offline, show it to alret dialoge
      if (error.toString() == "User not found for that email." ||
          error.toString() == "Email Not Valid.") {
        setState(() {
          _apiErrorForEmail = error.toString();
        });
        _formKey.currentState!.validate();
        // _focusNodeForEmail.requestFocus();
      } else if (error.toString() == "The password is wrong.") {
        setState(() {
          _apiErrorForPassword = error.toString();
        });
        _formKey.currentState!.validate();
        // _focusNodeForPassword.requestFocus();
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
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                key: const ValueKey('email'),
                focusNode: _focusNodeForEmail,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
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
                  _focusNodeForPassword.requestFocus();
                },
                validator: (value) {
                  if (value == null ||
                      value.trim().length < 5 ||
                      !value.contains('@')) {
                    return 'Please enter a valid email address.';
                  }
                  return _apiErrorForEmail;
                },
                onSaved: (value) {
                  _userEmail = value!.trim();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                key: const ValueKey('password'),
                focusNode: _focusNodeForPassword,
                obscureText: _isPasswordShowen ? false : true,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Password',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/remember_me_icon.svg",
                    height: 15,
                    // ignore: deprecated_member_use
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : null,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Remember me",
                    style: TextStyle(
                      color: Color.fromRGBO(143, 39, 83, 1),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: _saveForm,
                      style: const ButtonStyle(
                        fixedSize:
                            MaterialStatePropertyAll(Size.fromWidth(150)),
                      ),
                      child: const Text("Sign in"),
                    ),
              const SizedBox(height: 30),
              const OrDivider(),
              const SizedBox(height: 10),
              const SocialSignIn(),
              const SignInAsGuestButton(),
              const SizedBox(height: 80),
              DontOrAlreadyHaveAccount(
                text: "Don't have an account? ",
                actionText: "Sign Up",
                onTap: () {
                  Navigator.of(context).pushNamed(FirstSignUpScreen.routName);
                  _resetSignInState();
                },
              )
                  .animate(target: _isLoading ? 0 : 1)
                  .scaleXY(begin: 0, end: 1)
                  .fade(begin: 0, end: 1),
            ],
          ),
          Positioned(
            right: 0,
            top: 110,
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(SendPasswordResetEmailScreen.routName);
                _resetSignInState();
              },
              child: const Text(
                "Forgot password?",
                style: TextStyle(
                  color: Color.fromRGBO(143, 39, 83, 1),
                  fontSize: 15,
                ),
              ),
            )
                .animate(
                    target: _isLoading || _apiErrorForPassword == null ? 0 : 1)
                .scaleXY(begin: 0, end: 1)
                .fade(begin: 0, end: 1),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          "Or",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
