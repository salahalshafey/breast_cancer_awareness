import 'package:flutter_svg/svg.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user_information.dart';
import '../../domain/usecases/signin_with_email_and_password.dart';
import '../pages/first_sign_up_screen.dart';
import '../providers/account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../injection_container.dart' as di;

import '../../../../core/util/builders/custom_alret_dialoge.dart';
import 'dont_or_already_have_accout.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';
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

  Future<void> _saveForm() async {
    ///////// Validate all Fields /////////
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    ///////// Save the data from textFields /////////
    _formKey.currentState!.save();

    ///////// Login And handle the errors and loading /////////
    //final account = Provider.of<Account>(context, listen: false);
    try {
      _isLoadingState(true);
      // await account.signInUsingEmailAndPassword(_userEmail, _userPassword);
      final currentUser =
          await signInUsingEmailAndPassword(_userEmail, _userPassword);
      print(currentUser);
    } catch (error) {
      _isLoadingState(false);
      showCustomAlretDialog(
        context: context,
        title: 'ERROR',
        titleColor: Colors.red,
        content: '$error',
      );
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
                fillColor: _isEmailFocused ? focusColor : null),
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
              return null;
            },
            onSaved: (value) {
              _userEmail = value!;
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

              return null;
            },
            onSaved: (value) {
              _userPassword = value!;
            },
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/remember_me_icon.svg", height: 15),
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
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text("Sign in"),
                ),
          const SizedBox(height: 55),
          DontOrAlreadyHaveAccount(
            text: "Don't have an account ? ",
            actionText: "Sign Up",
            onTap: () {
              Navigator.of(context).pushNamed(FirstSignUpScreen.routName);
              _formKey.currentState!.reset();
              setState(() {
                _isPasswordIconShowen = false;
                _isPasswordShowen = false;
              });
            },
          ),
        ],
      ),
    );
  }
}

String? validatPassword(String? value) {
  if (value == null || value.trim().length < 8) {
    return 'Password must be at least 8 characters long.';
  }

  final numbers = "0123456789".characters.toSet();
  var countNum = 0;
  value.characters.toList().forEach((char) {
    if (numbers.contains(char)) countNum++;
  });
  if (countNum < 2) {
    return "Password must contain at least 2 numbers.";
  }

  final specialChar = "~!@#\$%^&*()_-+={}[]'\"\\;: ,.<>?/،؟".characters.toSet();
  var countSpecial = 0;
  value.characters.toList().forEach((char) {
    if (specialChar.contains(char)) countSpecial++;
  });
  if (countSpecial < 1) {
    return "Password must contain at least 1 special charachters like '~!@#\$%^&*()_'.";
  }

  return null;
}

Future<UserInformation> signInUsingEmailAndPassword(
    String email, String password) async {
  try {
    return await di
        .sl<SignInWithEmailAndPasswordUsecase>()
        .call(email, password);
  } on OfflineException {
    throw Error('You are currently offline.');
  } on ServerException {
    throw Error('Something went wrong, please try again later.');
  } on EmptyDataException {
    throw Error("Error happend, There is no data for that user");
  } on UserNotFoundException {
    throw Error("User not found for that email.");
  } on WrongPasswordException {
    throw Error("The password is wrong.");
  } on EmailNotValidException {
    throw Error("Email Not Valid.");
  } catch (error) {
    throw Error('An unexpected error happened.');
  }
}
