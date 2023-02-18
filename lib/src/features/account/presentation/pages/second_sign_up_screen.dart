import 'dart:io';

import 'package:breast_cancer_awareness/src/app.dart';
import 'package:breast_cancer_awareness/src/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../../../core/util/builders/custom_alret_dialoge.dart';
import '../../../../injection_container.dart' as di;
import 'package:breast_cancer_awareness/src/core/util/builders/image_picker.dart';
import 'package:breast_cancer_awareness/src/core/util/widgets/custom_card.dart';
import 'package:breast_cancer_awareness/src/core/util/widgets/image_container.dart';
import 'package:breast_cancer_awareness/src/features/account/domain/usecases/send_user_image_and_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/error/exceptions.dart';
import 'dart:developer' as developer;

import '../providers/account.dart';

class SecondSignUpScreen extends StatefulWidget {
  static const routName = '/sign-up2';

  const SecondSignUpScreen({super.key});

  @override
  State<SecondSignUpScreen> createState() => _SecondSignUpScreenState();
}

class _SecondSignUpScreenState extends State<SecondSignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  File? _currentImage;
  File? _previousImage;
  String _sellectedUserType = "";

  bool _isLoading = false;
  bool _isSkipForNowButtonShowen = false;

  late DateTime _dateTimeFromStartingThePage;

  @override
  void initState() {
    _dateTimeFromStartingThePage = DateTime.now();
    super.initState();
  }

  void _isLoadingState(bool state) {
    setState(() {
      _isLoading = state;
    });
  }

  void _sendUserImageAndType() async {
    final account = Provider.of<Account>(context, listen: false);
    try {
      _isLoadingState(true);
      await account.sendUserImageAndType(_currentImage, _sellectedUserType);

      await _goToMainScreen();
    } catch (error) {
      _isLoadingState(false);

      setState(() {
        _isSkipForNowButtonShowen = true;
      });

      showCustomAlretDialog(
        context: context,
        title: 'ERROR',
        titleColor: Colors.red,
        content: '$error',
      );
    }
  }

  Future<void> _goToMainScreen() async {
    final elapsedTime =
        DateTime.now().difference(_dateTimeFromStartingThePage).inSeconds.abs();
    if (elapsedTime < 10) {
      await Future.delayed((10 - elapsedTime).seconds);
    }

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const MyApp();
    }));
  }

  void _selectUserType(String userType) {
    setState(() {
      _sellectedUserType = userType;
    });
  }

  Future<void> _chooseImage() async {
    final imageXFile = await myImagePicker(context);
    if (imageXFile == null) {
      return;
    }

    setState(() {
      _previousImage = _currentImage;
      _currentImage = File(imageXFile.path);
    });
  }

  double get _horizantalPadding {
    final screenWidth = MediaQuery.of(context).size.width;
    var horizantalPadding = 15.0;
    if (screenWidth > 500) {
      horizantalPadding += (screenWidth - 500) / 2;
    }

    return horizantalPadding;
  }

  @override
  Widget build(BuildContext context) {
    // final m = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: Text("data go from back"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          if (Theme.of(context).brightness == Brightness.light)
            Positioned(
              bottom: -30,
              child: Opacity(
                opacity: 0.7,
                child: Image.asset(
                  "assets/images/background_cancer_sympol.png",
                  scale: 1.5,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ListView(
            padding: EdgeInsets.symmetric(
                horizontal: _horizantalPadding, vertical: 60),
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  _previousImage == null
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "assets/images/person_avatar.png",
                            height: 140,
                            filterQuality: FilterQuality.high,
                          ),
                        )
                          .animate(
                            onPlay: (controller) {},
                          )
                          .fadeOut(
                              duration: _previousImage == null &&
                                      _currentImage == null
                                  ? 0.0.seconds
                                  : 1.5.seconds)
                      : ImageContainer(
                          image: _previousImage!.path,
                          imageSource: From.file,
                          radius: 70,
                          shape: BoxShape.circle,
                          fit: BoxFit.cover,
                          border: Border.all(
                            color: const Color.fromRGBO(203, 100, 140, 1),
                            width: 2,
                          ),
                          showHighlight: true,
                          showImageDialoge: true,
                        )
                          .animate(
                            onPlay: (controller) {},
                          )
                          .fadeOut(duration: 1.5.seconds),
                  _currentImage == null
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "assets/images/person_avatar.png",
                            height: 140,
                            filterQuality: FilterQuality.high,
                          ),
                        )
                          .animate(
                              onPlay: (controller) {},
                              delay: _previousImage == null &&
                                      _currentImage == null
                                  ? 0.0.seconds
                                  : 1.5.seconds)
                          .fadeIn(
                              duration: _previousImage == null &&
                                      _currentImage == null
                                  ? 0.0.seconds
                                  : 1.5.seconds)
                      : ImageContainer(
                          image: _currentImage!.path,
                          imageSource: From.file,
                          radius: 70,
                          shape: BoxShape.circle,
                          fit: BoxFit.cover,
                          border: Border.all(
                            color: const Color.fromRGBO(203, 100, 140, 1),
                            width: 2,
                          ),
                          showHighlight: true,
                          showImageDialoge: true,
                        )
                          .animate(onPlay: (controller) {}, delay: 1.5.seconds)
                          .fadeIn(duration: 1.5.seconds)
                ],
              ),
              /*AnimatedSwitcher(
                duration: 1.5.seconds,
                child: _currentImage == null
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/images/person_avatar.png",
                          height: 140,
                          filterQuality: FilterQuality.high,
                        ),
                      )
                    : ImageContainer(
                        image: _currentImage!.path,
                        imageSource: From.file,
                        radius: 70,
                        shape: BoxShape.circle,
                        fit: BoxFit.cover,
                        border: Border.all(
                          color: const Color.fromRGBO(203, 100, 140, 1),
                          width: 2,
                        ),
                        showHighlight: true,
                        showImageDialoge: true,
                      ),
              ),*/
              const SizedBox(height: 10),
              Align(
                child: ElevatedButton(
                  onPressed: _chooseImage,
                  child: const Text("Choose Image"),
                ),
              ),
              const SizedBox(height: 60),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(196, 143, 171, 0.22),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Text(
                    "Select User Type",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SellectUserType(
                currentSelectedUser: _sellectedUserType,
                onSelected: _selectUserType,
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: _isSkipForNowButtonShowen
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
                children: [
                  if (_isSkipForNowButtonShowen)
                    TextButton(
                      onPressed: _goToMainScreen,
                      child: const Text(
                        "Skip For Now",
                      ),
                    ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _sendUserImageAndType,
                          child: const Text(
                            "Continue",
                          ),
                        ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SellectUserType extends StatelessWidget {
  const SellectUserType({
    super.key,
    required this.onSelected,
    required this.currentSelectedUser,
  });

  final void Function(String sellectedUser) onSelected;
  final String currentSelectedUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UserType(
          userType: "Normal",
          userAssetIcon: "assets/icons/normal_user_icon.png",
          iconHeight: 50,
          isSelected: currentSelectedUser == "Normal",
          onTap: onSelected,
        ),
        UserType(
          userType: "Doctor",
          userAssetIcon: "assets/icons/doctor_icon.png",
          iconHeight: 65,
          isSelected: currentSelectedUser == "Doctor",
          onTap: onSelected,
        ),
        UserType(
          userType: "Patient",
          userAssetIcon: "assets/icons/patient_icon.svg",
          iconHeight: 50,
          isSelected: currentSelectedUser == "Patient",
          onTap: onSelected,
        ),
      ],
    );
  }
}

class UserType extends StatelessWidget {
  const UserType({
    super.key,
    required this.userType,
    required this.userAssetIcon,
    required this.iconHeight,
    required this.isSelected,
    required this.onTap,
  });

  final String userType;
  final String userAssetIcon;
  final double iconHeight;
  final bool isSelected;
  final void Function(String userType) onTap;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final isDoctor = userType == "Doctor";

    return Align(
      child: CustomCard(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        color: isSelected
            ? primaryColor
            : const Color.fromRGBO(229, 183, 207, 0.22),
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(color: Color.fromRGBO(112, 112, 112, 1)),
        elevation: 0, //isSellected ? 20 : 15,
        onTap: () => onTap(userType),
        child: Column(
          children: [
            Container(
              width: iconHeight + (isDoctor ? 0 : 10),
              padding: isDoctor ? null : const EdgeInsets.all(5),
              decoration: isDoctor
                  ? null
                  : const BoxDecoration(
                      color: Color.fromRGBO(190, 215, 255, 1),
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                          BorderSide(color: Colors.white)),
                    ),
              child: IconFromAsset(
                assetIcon: userAssetIcon,
                iconHeight: iconHeight,
              ),
            ),
            Text(
              userType,
              style: TextStyle(
                color: isSelected ? Colors.white : primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    )
        .animate(target: isSelected ? 1 : 0)
        .scaleXY(end: 1.1, duration: 200.ms)
        .boxShadow(
          begin: BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: const Offset(10, 10),
            blurRadius: 10,
          ),
          end: BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: const Offset(15, 15),
            blurRadius: 15,
          ),
          borderRadius: BorderRadius.circular(30),
        );

    // .elevation(begin: 10, end: 17);
    //.tint(color: primaryColor.withOpacity(0.3));
  }
}

class IconFromAsset extends StatelessWidget {
  const IconFromAsset({
    super.key,
    required this.assetIcon,
    required this.iconHeight,
  });

  final String assetIcon;
  final double iconHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: assetIcon.endsWith(".svg")
          ? SvgPicture.asset(
              assetIcon,
              height: iconHeight,
            )
          : Image.asset(
              assetIcon,
              height: iconHeight,
              //filterQuality: FilterQuality.high,
            ),
    );
  }
}

Future<String?> _sendUserImageAndType(File? image, String userType) async {
  try {
    return await di.sl<SendUserImageAndTypeUseCase>().call(image, userType);
  } on OfflineException {
    throw Error('You are currently offline.');
  } on ServerException {
    throw Error('Something went wrong, please try again later.');
  } on EmptyDataException {
    throw Error("Error happend, There is no data for that user");
  } catch (error) {
    throw Error('An unexpected error happened.');
  }
}
