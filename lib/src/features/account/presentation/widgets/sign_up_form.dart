import 'dart:math';

import 'package:breast_cancer_awareness/src/features/account/domain/usecases/signup_with_email_and_password.dart';
import 'package:breast_cancer_awareness/src/features/account/presentation/pages/second_sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/builders/custom_alret_dialoge.dart';
import '../../../../injection_container.dart' as di;

import '../../domain/entities/user_information.dart';
import '../../domain/usecases/signin_with_email_and_password.dart';

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
    ///////// Validate all Fields /////////
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    ///////// Save the data from textFields /////////
    _formKey.currentState!.save();

    ///////// Send the inputs to the next screen /////////
    //final account = Provider.of<Account>(context, listen: false);
    try {
      _isLoadingState(true);
      // await account.signUpUsingEmailAndPassword(_editedUserInformation, _userPassword);
      final currentUser = await signUpUsingEmailAndPassword(
          _editedUserInformation, _userPassword);
      print(currentUser);
      Navigator.of(context).pop();
    } catch (error) {
      _isLoadingState(false);
      showCustomAlretDialog(
        context: context,
        title: 'ERROR',
        titleColor: Colors.red,
        content: '$error',
      );
    }
    /*Navigator.of(context).pushNamed(
      SecondSignUpScreen.routName,
      arguments: {
        "user_info": _editedUserInformation,
        "password": _userPassword,
      },
    );*/
  }

  @override
  Widget build(BuildContext context) {
    final focusColor = Theme.of(context).primaryColor;

    final screenWidth = MediaQuery.of(context).size.width;
    var horizantalPadding = 40.0;
    if (screenWidth > 600) {
      horizantalPadding = (screenWidth - 600) / 2 + 40.0;
    }

    // width of entire screen - padding of above ListView - width between 2 forms
    final widthOfNameForm = (screenWidth - horizantalPadding * 2 - 15) / 2;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                      hintText: 'First name',
                      fillColor: _isFirstNameFocused ? focusColor : null),
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
                    _editedUserInformation =
                        _editedUserInformation.copyWith(firstName: value);
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
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                      hintText: 'Last name',
                      fillColor: _isLastNameFocused ? focusColor : null),
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
                    _editedUserInformation =
                        _editedUserInformation.copyWith(lastName: value);
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
              _editedUserInformation =
                  _editedUserInformation.copyWith(email: value);
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
            validator: _validatPassword3,
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
              Transform.rotate(
                angle: pi,
                child: SvgPicture.asset(
                  "assets/icons/sign_up_icon.svg",
                  height: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String? _validatPassword(String? value) {
  const errorMessage =
      "Password must be at least 8 characters long, with at least 5 alphabet, 2 numbers and 1 special charachters like '~!@#\$%^&*()_'.";

  if (value == null || value.length < 8) {
    return errorMessage;
  }

  final alphabet =
      ("abcdefghijklmnopqrstuvwxyz${"abcdefghijklmnopqrstuvwxyz".toUpperCase()}")
          .characters
          .toSet();
  var countAlpha = 0;
  value.characters.toList().forEach((char) {
    if (alphabet.contains(char)) countAlpha++;
  });
  if (countAlpha < 5) {
    return errorMessage;
  }

  final numbers = "0123456789".characters.toSet();
  var countNum = 0;
  value.characters.toList().forEach((char) {
    if (numbers.contains(char)) countNum++;
  });
  if (countNum < 2) {
    return errorMessage;
  }

  final specialChar = "~!@#\$%^&*()_-+={}[]'\"\\;: ,.<>?/،؟".characters.toSet();
  var countSpecial = 0;
  value.characters.toList().forEach((char) {
    if (specialChar.contains(char)) countSpecial++;
  });
  if (countSpecial < 1) {
    return errorMessage;
  }

  return null;
}

String? _validatPassword2(String? value) {
  if (value == null || value.trim().length < 8) {
    return 'Password must be at least 8 characters long.';
  }

  final alphabet =
      ("abcdefghijklmnopqrstuvwxyz${"abcdefghijklmnopqrstuvwxyz".toUpperCase()}")
          .characters
          .toSet();
  var countAlpha = 0;
  value.characters.toList().forEach((char) {
    if (alphabet.contains(char)) countAlpha++;
  });
  if (countAlpha < 5) {
    return "Password must contain at least 5 alphabet characters.";
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

String? _validatPassword3(String? value) {
  if (value == null || value.length < 8) {
    return "Password must be at least 8 characters long, with at least 5 alphabet, 2 numbers and 1 special charachters like '~!@#\$%^&*()_'.";
  }

  List<String> validationValues = [];

  final alphabet =
      ("abcdefghijklmnopqrstuvwxyz${"abcdefghijklmnopqrstuvwxyz".toUpperCase()}")
          .characters
          .toSet();
  var countAlpha = 0;
  value.characters.toList().forEach((char) {
    if (alphabet.contains(char)) countAlpha++;
  });
  if (countAlpha < 5) {
    validationValues.add("5 alphabet characters");
  }

  final numbers = "0123456789".characters.toSet();
  var countNum = 0;
  value.characters.toList().forEach((char) {
    if (numbers.contains(char)) countNum++;
  });
  if (countNum < 2) {
    validationValues.add("2 numbers");
  }

  final specialChar = "~!@#\$%^&*()_-+={}[]'\"\\;: ,.<>?/،؟".characters.toSet();
  var countSpecial = 0;
  value.characters.toList().forEach((char) {
    if (specialChar.contains(char)) countSpecial++;
  });
  if (countSpecial < 1) {
    validationValues.add("1 special charachters like '~!@#\$%^&*()_'.");
  }

  return _joinValidations(validationValues);
}

String? _joinValidations(List<String> validations) {
  if (validations.isEmpty) {
    return null;
  }

  const s = "Password must contain at least ";
  if (validations.length == 1) {
    return s + validations.join();
  } else {
    return "$s${validations.sublist(0, validations.length - 1).join(", ")} and ${validations.last}";
  }
}

Future<UserInformation> signUpUsingEmailAndPassword(
  UserInformation userInformation,
  String password,
) async {
  try {
    return await di
        .sl<SignUpWithEmailAndPasswordUsecase>()
        .call(userInformation, password);
  } on OfflineException {
    throw Error('You are currently offline.');
  } on ServerException {
    throw Error('Something went wrong, please try again later.');
  } on EmptyDataException {
    throw Error("Error happend, There is no data for that user");
  } on WeakPasswordException {
    throw Error("The provided password is weak try to put a strong password.");
  } on EmailAlreadyInUseException {
    throw Error(
        "The provided email already exists, sign in instead or provide another email.");
  } on EmailNotValidException {
    throw Error("Email Not Valid.");
  } catch (error) {
    throw Error('An unexpected error happened.');
  }
}
