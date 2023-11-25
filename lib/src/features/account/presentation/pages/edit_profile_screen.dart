import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

import '../../../../core/util/builders/image_picker.dart';
import '../../../../core/util/extensions/list_seperator.dart';
import '../../../../core/util/functions/string_manipulations_and_search.dart';
import '../../../../core/util/widgets/default_screen.dart';

import '../../domain/entities/user_information.dart';

import '../widgets/profile/choose_user_type.dart';
import '../widgets/profile/edit_profile_form.dart';
import '../widgets/profile/edit_profile_image.dart';
import '../widgets/profile/save_edit_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen(this.userInfo, {super.key});

  final UserInformation userInfo;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? _fileImagePath;
  late String _userType = widget.userInfo.userType;

  late final _firstNameController =
      TextEditingController(text: widget.userInfo.firstName);
  late final _lastNameController =
      TextEditingController(text: widget.userInfo.lastName);
  late final _phoneNumberController =
      TextEditingController(text: widget.userInfo.phoneNumber);

  @override
  void initState() {
    _getImageFromLocal();

    super.initState();
  }

  void _getImageFromLocal() async {
    final imageUrl = widget.userInfo.imageUrl;

    if (imageUrl == null) {
      return;
    }

    final localImage = await _imageLocalPath(imageUrl);

    _fileImagePath = localImage ?? await _downloadAndSaveTheImage(imageUrl);

    setState(() {});
  }

  void _chooseImage() async {
    final imageXFile = await myImagePicker(context);

    if (imageXFile == null) {
      return;
    }

    setState(() {
      _fileImagePath = imageXFile.path;
    });
  }

  void _clearTheImage() {
    setState(() {
      _fileImagePath = null;
    });
  }

  void _renderState() {
    setState(() {});
  }

  void _changeUserType(String userType) {
    setState(() {
      _userType = userType;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var horizantalPadding = 20.0;
    if (screenWidth > 600) {
      horizantalPadding += (screenWidth - 600) / 2;
    }

    return DefaultScreen(
      containingBackgroundRightSympol: false,
      appBartitle: "Edit Profile",
      appBarbackgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromRGBO(28, 27, 31, 1)
          : Colors.white,
      appBarLeading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.close, size: 40),
        tooltip: "Cancel",
      ),
      appBarActions: [
        SaveEditButton(
          updatedUserInfo: widget.userInfo
              .copyWith(
                firstName: _firstNameController.text.trim(),
                lastName: _lastNameController.text.trim(),
                userType: _userType,
              )
              .copyWithPhoneNumber(
                _phoneNumberController.text.trim().isEmpty
                    ? null
                    : _phoneNumberController.text.trim(),
              ),
          updatedImagePath: _fileImagePath,
          currentUserInfo: widget.userInfo,
        ),
      ],
      child: ListView(
        padding:
            EdgeInsets.symmetric(vertical: 120, horizontal: horizantalPadding),
        children: [
          EditProfileImage(
            fileImagePath: _fileImagePath,
            imageTitle: wellFormatedString(
                "${_firstNameController.text} ${_lastNameController.text}"),
            imageCaption: _phoneNumberController.text.trim().isEmpty
                ? null
                : _phoneNumberController.text,
            chooseImage: _chooseImage,
            clearTheImage: _clearTheImage,
          ),
          EditProfileForm(
            firstNameController: _firstNameController,
            lastNameController: _lastNameController,
            phoneNumberController: _phoneNumberController,
            renderState: _renderState,
          ),
          ChooseUserType(
            userType: _userType,
            changeUserType: _changeUserType,
          ),
        ].verticalSeperateBy(const SizedBox(height: 60)),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////
///
///

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

Future<String> _downloadAndSaveTheImage(String networkImage) async {
  try {
    final docDir = await getApplicationDocumentsDirectory();

    final docPath = '${docDir.path}/${networkImage.hashCode}.jpeg';

    await Dio().download(networkImage, docPath);

    return docPath;
  } catch (_) {
    return '';
  }
}
