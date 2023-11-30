import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/util/functions/string_manipulations_and_search.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneNumberController,
    required this.renderState,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneNumberController;
  final void Function() renderState;

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final _focusNodeForFirstName = FocusNode();
  final _focusNodeForLastName = FocusNode();
  final _focusNodeForPhoneNumber = FocusNode();

  bool _isFirstNameFocused = false;
  bool _isLastNameFocused = false;
  bool _isPhoneFocused = false;

  late TextDirection _textDirectionForFirstName =
      firstCharIsArabic(widget.firstNameController.text)
          ? TextDirection.rtl
          : TextDirection.ltr;
  late TextDirection _textDirectionForLastName =
      firstCharIsArabic(widget.lastNameController.text)
          ? TextDirection.rtl
          : TextDirection.ltr;

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

    _focusNodeForPhoneNumber.addListener(() {
      setState(() {
        _isPhoneFocused = _focusNodeForPhoneNumber.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNodeForFirstName.dispose();
    _focusNodeForLastName.dispose();
    _focusNodeForPhoneNumber.dispose();

    super.dispose();
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
                  controller: widget.firstNameController,
                  focusNode: _focusNodeForFirstName,
                  textDirection: _textDirectionForFirstName,
                  autocorrect: false,
                  enableSuggestions: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
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
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the first name.';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    widget.renderState();

                    setState(() {
                      _textDirectionForFirstName = firstCharIsArabic(value)
                          ? TextDirection.rtl
                          : TextDirection.ltr;
                    });
                  },
                ),
              ),
              SizedBox(
                width: widthOfNameForm,
                child: TextFormField(
                  key: const ValueKey('last name'),
                  controller: widget.lastNameController,
                  focusNode: _focusNodeForLastName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textDirection: _textDirectionForLastName,
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
                    _focusNodeForPhoneNumber.requestFocus();
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the last name.';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    widget.renderState();

                    setState(() {
                      _textDirectionForLastName = firstCharIsArabic(value)
                          ? TextDirection.rtl
                          : TextDirection.ltr;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          TextFormField(
            key: const ValueKey('phoneNumber'),
            controller: widget.phoneNumberController,
            focusNode: _focusNodeForPhoneNumber,
            enableSuggestions: false,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[0-9()+\-\. ]"))
            ],
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
              hintText: 'Phone Number',
              errorMaxLines: 3,
              fillColor: _isPhoneFocused ? focusColor : null,
              prefixIcon: const Icon(Icons.phone_android_rounded),
              prefixIconColor: Colors.white,
            ),
            onTapOutside: (_) {
              _focusNodeForPhoneNumber.unfocus();
            },
            onFieldSubmitted: (value) {
              _focusNodeForPhoneNumber.unfocus();
            },
            validator: (value) {
              // if all the value is phone number
              final phoneNumberMatcher = RegExp(
                  r"^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{2,3}\)?[\s.-]?\d{3,4}[\s.-]?\d{3,5}$");
              if (value != null &&
                  value.isNotEmpty &&
                  !phoneNumberMatcher.hasMatch(value)) {
                return 'Please enter a valid Phone Number.';
              }

              return null;
            },
            onChanged: (value) {
              widget.renderState();
            },
          ),
        ],
      ),
    );
  }
}
