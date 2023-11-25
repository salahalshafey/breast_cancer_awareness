// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../core/util/builders/custom_alret_dialoge.dart';

import '../../../domain/entities/user_information.dart';

import '../../providers/account.dart';

class SaveEditButton extends StatefulWidget {
  const SaveEditButton({
    super.key,
    required this.updatedUserInfo,
    required this.updatedImagePath,
    required this.currentUserInfo,
  });

  final UserInformation updatedUserInfo;
  final String? updatedImagePath;
  final UserInformation currentUserInfo;

  @override
  State<SaveEditButton> createState() => _SaveEditButtonState();
}

class _SaveEditButtonState extends State<SaveEditButton> {
  bool _isLoading = false;

  void _setLoadingState(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  void _saveTheEdit() async {
    try {
      _setLoadingState(true);

      if (widget.updatedUserInfo.firstName.isEmpty ||
          widget.updatedUserInfo.lastName.isEmpty) {
        throw ErrorDescription("Some Fields are Empty");
      }

      if (widget.updatedUserInfo.phoneNumber != null &&
          widget.updatedUserInfo.phoneNumber!.isNotValidPhoneNumber) {
        throw ErrorDescription("Please enter a valid Phone Number.");
      }

      final account = Provider.of<Account>(context, listen: false);
      final imageUpdated = await _isImageUpdated(
        widget.currentUserInfo.imageUrl,
        widget.updatedImagePath,
      );

      await account.addOrUpdateUserData(
        widget.updatedUserInfo,
        widget.updatedImagePath == null ? null : File(widget.updatedImagePath!),
        imageUpdated: imageUpdated,
      );

      Navigator.of(context).pop();
    } catch (error) {
      _setLoadingState(false);

      showCustomAlretDialog(
        context: context,
        title: "Error",
        content: error.toString(),
        titleColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: false,
      future: _isProfileUpdated(
        widget.currentUserInfo,
        widget.updatedUserInfo,
        widget.updatedImagePath,
      ),
      builder: (context, snapshot) {
        final isProfileUpdated = snapshot.data!;

        return _isLoading
            ? Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
                ),
              )
            : IconButton(
                onPressed: isProfileUpdated ? _saveTheEdit : null,
                icon: const Icon(Icons.check, size: 40),
                tooltip: "Save",
              );
      },
    );
  }
}

extension on String {
  bool get isValidPhoneNumber {
    final phoneNumberMatcher = RegExp(
        r"^(?:01[0125][0-9]{8}|(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4})$");

    return phoneNumberMatcher.hasMatch(this);
  }

  bool get isNotValidPhoneNumber => !isValidPhoneNumber;
}

///////////////////////////////////////////////////////////////////////////
///
///

Future<bool> _isProfileUpdated(
  UserInformation currentUser,
  UserInformation updatedUser,
  String? updatedImagePath,
) async =>
    currentUser.firstName != updatedUser.firstName ||
    currentUser.lastName != updatedUser.lastName ||
    currentUser.phoneNumber != updatedUser.phoneNumber ||
    currentUser.userType != updatedUser.userType ||
    await _isImageUpdated(currentUser.imageUrl, updatedImagePath);

Future<bool> _isImageUpdated(String? networkImage, String? fileImage) async {
  if ((networkImage == null && fileImage != null) ||
      (networkImage != null && fileImage == null)) {
    return true;
  }

  if (networkImage == null && fileImage == null) {
    return false;
  }

  final networkImagePathFromlocal = await _imageLocalPath(networkImage!);

  return networkImagePathFromlocal != fileImage;
}

Future<String?> _imageLocalPath(String networkImage) async {
  try {
    final docDir = await getApplicationDocumentsDirectory();
    final docPath = '${docDir.path}/${networkImage.hashCode}.jpeg';
    final existsIndir = await File(docPath).exists();
    if (existsIndir) {
      return docPath;
    }
  } catch (_) {
    return null;
  }

  // return null if image not exists in a local path
  return null;
}
