import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/user_information.dart';

import '../providers/account.dart';

import '../../../../core/util/builders/custom_alret_dialoge.dart';
import '../../../../core/util/functions/password_validation.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  var _userPassword = '';
  var _editedUserInformation = UserInformation(
    id: "",
    firstName: "",
    lastName: "",
    email: "",
    imageUrl: null,
    dateOfSignUp: DateTime.now(),
    userType: "Normal",
  );

  String? _apiErrorForEmail;
  String? _apiErrorForPassword;

  final _focusNodeForFirstName = FocusNode();
  final _focusNodeForLastName = FocusNode();
  final _focusNodeForEmail = FocusNode();
  final _focusNodeForPassword = FocusNode();
  final _focusNodeForConfirmPassword = FocusNode();

  bool _isFirstNameFocused = false;
  bool _isLastNameFocused = false;
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _isPasswordConfirmFocused = false;

  bool _isPasswordIconShowen = false;
  bool _isPasswordConfirmIconShowen = false;
  bool _isPasswordShowen = false;

  bool _isLoading = false;

  void _isLoadingState(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  @override
  void initState() {
    super.initState();

    _focusNodeForFirstName.addListener(() {
      setState(() {
        _isFirstNameFocused = _focusNodeForFirstName.hasFocus;
      });
    });

    _focusNodeForLastName.addListener(() {
      setState(() {
        _isLastNameFocused = _focusNodeForLastName.hasFocus;
      });
    });

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

    _focusNodeForConfirmPassword.addListener(() {
      setState(() {
        _isPasswordConfirmFocused = _focusNodeForConfirmPassword.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNodeForFirstName.dispose();
    _focusNodeForLastName.dispose();
    _focusNodeForEmail.dispose();
    _focusNodeForPassword.dispose();
    _focusNodeForConfirmPassword.dispose();

    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _saveForm() async {
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

    ///////// Send the inputs to the next screen /////////
    final account = Provider.of<Account>(context, listen: false);
    try {
      _isLoadingState(true);
      await account.signUpUsingEmailAndPassword(
          _editedUserInformation, _userPassword);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } catch (error) {
      _isLoadingState(false);

      // if the error on any textField show that error on the validator
      // if not, for example you are offline, show it to alret dialoge
      if (error.toString() ==
              "The provided email already exists, sign in instead or provide another email." ||
          error.toString() == "Email Not Valid.") {
        setState(() {
          _apiErrorForEmail = error.toString();
        });
        _formKey.currentState!.validate();
        // _focusNodeForEmail.requestFocus();
      } else if (error.toString() ==
          "The provided password is weak try to put a strong password.") {
        setState(() {
          _apiErrorForPassword = error.toString();
        });
        _formKey.currentState!.validate();
        _focusNodeForPassword.requestFocus();
        _confirmPasswordController.clear();
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

    final screenWidth = MediaQuery.of(context).size.width;
    var horizantalPadding = 25.0;
    if (screenWidth > 600) {
      horizantalPadding += (screenWidth - 600) / 2;
    }

    // width of entire screen - padding of above ListView - width between 2 forms
    final widthOfNameForm = (screenWidth - horizantalPadding * 2 - 15) / 2;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: widthOfNameForm,
                child: TextFormField(
                  key: const ValueKey('first name'),
                  focusNode: _focusNodeForFirstName,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'First name',
                    fillColor: _isFirstNameFocused ? focusColor : null,
                    errorMaxLines: 2,
                  ),
                  onTapOutside: (_) {
                    _focusNodeForFirstName.unfocus();
                  },
                  onFieldSubmitted: (value) {
                    _focusNodeForLastName.requestFocus();
                  },
                  validator: (value) {
                    if (value == null || value.trim().length < 2) {
                      return 'Please enter a valid name.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    final enhancedValue =
                        value!.trim().split(RegExp(r' +')).join(' ');

                    _editedUserInformation = _editedUserInformation.copyWith(
                        firstName: enhancedValue);
                  },
                ),
              ),
              const SizedBox(width: 15),
              SizedBox(
                width: widthOfNameForm,
                child: TextFormField(
                  key: const ValueKey('last name'),
                  focusNode: _focusNodeForLastName,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Last name',
                    fillColor: _isLastNameFocused ? focusColor : null,
                    errorMaxLines: 2,
                  ),
                  onTapOutside: (_) {
                    _focusNodeForLastName.unfocus();
                  },
                  onFieldSubmitted: (value) {
                    _focusNodeForEmail.requestFocus();
                  },
                  validator: (value) {
                    if (value == null || value.trim().length < 2) {
                      return 'Please enter a valid name.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    final enhancedValue =
                        value!.trim().split(RegExp(r' +')).join(' ');
                    _editedUserInformation = _editedUserInformation.copyWith(
                        lastName: enhancedValue);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          TextFormField(
            key: const ValueKey('email'),
            focusNode: _focusNodeForEmail,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
                hintText: 'Email',
                errorMaxLines: 3,
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
              return _apiErrorForEmail;
            },
            onSaved: (value) {
              _editedUserInformation =
                  _editedUserInformation.copyWith(email: value!.trim());
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            key: const ValueKey('password'),
            focusNode: _focusNodeForPassword,
            obscureText: _isPasswordShowen ? false : true,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
              hintText: 'Password',
              errorMaxLines: 3,
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
              _userPassword = value;

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
              _focusNodeForConfirmPassword.requestFocus();
            },
            validator: (value) {
              final validation = validatPassword3(value);
              if (validation == null) {
                return _apiErrorForPassword;
              }

              return validation;
            },
            onSaved: (value) {
              _userPassword = value!;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            key: const ValueKey('confirm password'),
            controller: _confirmPasswordController,
            focusNode: _focusNodeForConfirmPassword,
            obscureText: _isPasswordShowen ? false : true,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              errorMaxLines: 1,
              fillColor: _isPasswordConfirmFocused ? focusColor : null,
              suffixIconColor: Colors.white,
              suffixIcon: _isPasswordConfirmIconShowen
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
                  _isPasswordConfirmIconShowen = true;
                });
              } else {
                setState(() {
                  _isPasswordConfirmIconShowen = false;
                  _isPasswordShowen = false;
                });
              }
            },
            onTapOutside: (_) {
              _focusNodeForConfirmPassword.unfocus();
            },
            onFieldSubmitted: (value) {
              _saveForm();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Empty Field, Please confirm the password.";
              }

              if (value != _userPassword) {
                _confirmPasswordController.clear();
                _focusNodeForConfirmPassword.requestFocus();
                return "Those passwords didn't match. Try again.";
              }

              return null;
            },
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _saveForm,
                      child: const Text("Sign Up"),
                    ),
              if (_isLoading) const SizedBox(width: 30),
              /*IconFromAsset(
                assetIcon: "assets/icons/sign_up_icon.png",
                iconHeight: 40,
                opacity:
                    Theme.of(context).brightness == Brightness.dark ? 0.7 : 1,
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
