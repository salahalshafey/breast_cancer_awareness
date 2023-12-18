// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/error/error_exceptions_with_message.dart';
import '../../domain/entities/user_information.dart';

import '../providers/account.dart';

import '../../../../core/util/builders/custom_alret_dialog.dart';
import '../../../../core/util/functions/password_validation.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';

import 'dont_or_already_have_accout.dart';

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
    phoneNumber: null,
    imageUrl: null,
    dateOfSignUp: DateTime.now(),
    userType: UserTypes.normal,
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

  TextDirection? _firstNameTextDirection;
  TextDirection? _lastNameTextDirection;

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

      Navigator.of(context).pop();
    } on ErrorForEmailTextField catch (error) {
      // if the error on any textField show that error on the validator
      // if not, for example you are offline, show it to alret dialoge

      _isLoadingState(false);

      setState(() {
        _apiErrorForEmail = error.toString();
      });
      _formKey.currentState!.validate();
      // _focusNodeForEmail.requestFocus();
    } on ErrorForPasswordTextField catch (error) {
      _isLoadingState(false);

      setState(() {
        _apiErrorForPassword = error.toString();
      });
      _formKey.currentState!.validate();
      // _focusNodeForPassword.requestFocus();
    } catch (error) {
      _isLoadingState(false);

      showCustomAlretDialog(
        context: context,
        title: AppLocalizations.of(context)!.error,
        titleColor: Colors.red,
        content: '$error',
      );
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: widthOfNameForm,
                child: TextFormField(
                  key: const ValueKey('first name'),
                  focusNode: _focusNodeForFirstName,
                  autocorrect: false,
                  enableSuggestions: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textDirection: _firstNameTextDirection,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.firstName,
                    fillColor: _isFirstNameFocused ? focusColor : null,
                    errorMaxLines: 2,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _firstNameTextDirection = firstCharIsRtl(value)
                          ? TextDirection.rtl
                          : TextDirection.ltr;
                    });
                  },
                  onTapOutside: (_) {
                    _focusNodeForFirstName.unfocus();
                  },
                  onFieldSubmitted: (value) {
                    _focusNodeForLastName.requestFocus();
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!
                          .pleaseEnterTheFirstName;
                    }
                    if (value.trim().length < 2) {
                      return AppLocalizations.of(context)!
                          .pleaseEnterAValidName;
                    }

                    return null;
                  },
                  onSaved: (value) {
                    final enhancedValue =
                        value!.trim().split(RegExp(r' +')).join(' ');

                    _editedUserInformation = _editedUserInformation.copyWith(
                      firstName: enhancedValue,
                    );
                  },
                ),
              ),
              SizedBox(
                width: widthOfNameForm,
                child: TextFormField(
                  key: const ValueKey('last name'),
                  focusNode: _focusNodeForLastName,
                  autocorrect: false,
                  enableSuggestions: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textDirection: _lastNameTextDirection,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.lastName,
                    fillColor: _isLastNameFocused ? focusColor : null,
                    errorMaxLines: 2,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _lastNameTextDirection = firstCharIsRtl(value)
                          ? TextDirection.rtl
                          : TextDirection.ltr;
                    });
                  },
                  onTapOutside: (_) {
                    _focusNodeForLastName.unfocus();
                  },
                  onFieldSubmitted: (value) {
                    _focusNodeForEmail.requestFocus();
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!
                          .pleaseEnterTheLastName;
                    }
                    if (value.trim().length < 2) {
                      return AppLocalizations.of(context)!
                          .pleaseEnterAValidName;
                    }

                    return null;
                  },
                  onSaved: (value) {
                    final enhancedValue =
                        value!.trim().split(RegExp(r' +')).join(' ');
                    _editedUserInformation = _editedUserInformation.copyWith(
                      lastName: enhancedValue,
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          TextFormField(
            key: const ValueKey('email'),
            focusNode: _focusNodeForEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            enableSuggestions: false,
            textCapitalization: TextCapitalization.none,
            inputFormatters: [FilteringTextInputFormatter.deny(" ")],
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textDirection: TextDirection.ltr,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.email,
                errorMaxLines: 3,
                fillColor: _isEmailFocused ? focusColor : null),
            onTapOutside: (_) {
              _focusNodeForEmail.unfocus();
            },
            onFieldSubmitted: (value) {
              _focusNodeForPassword.requestFocus();
            },
            validator: (value) {
              // if all the value is email
              final emailMatcher =
                  RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$");
              if (value == null || !emailMatcher.hasMatch(value)) {
                return AppLocalizations.of(context)!
                    .pleaseEnterAValidEmailAddress;
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: _isPasswordShowen ? false : true,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.password,
              errorMaxLines: 4,
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
              if (validation != null) {
                return validation;
              }

              return _apiErrorForPassword;
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: _isPasswordShowen ? false : true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            textDirection: TextDirection.ltr,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.confirmPassword,
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
                return AppLocalizations.of(context)!
                    .emptyFieldPleaseConfirmThePassword;
              }

              if (value != _userPassword) {
                //  _confirmPasswordController.clear();
                // _focusNodeForConfirmPassword.requestFocus();
                return AppLocalizations.of(context)!
                    .thosePasswordsDidntMatchTryAgain;
              }

              return null;
            },
          ),
          const SizedBox(height: 30),
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 11),
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: _saveForm,
                  child: Text(AppLocalizations.of(context)!.signUp),
                ),
          /*  Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 11),
                      child: CircularProgressIndicator(),
                    )
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
          ),*/
          const SizedBox(height: 30),
          PopScope(
            canPop: !_isLoading, // if loading don't pop
            child: DontOrAlreadyHaveAccount(
              text: AppLocalizations.of(context)!.alreadyHaveAnAccount,
              actionText: AppLocalizations.of(context)!.signIn,
              onTap: () {
                Navigator.of(context).pop();
              },
            )
                .animate(target: _isLoading ? 0 : 1)
                .scaleXY(begin: 0, end: 1)
                .fade(begin: 0, end: 1),
          ),
        ],
      ),
    );
  }
}
