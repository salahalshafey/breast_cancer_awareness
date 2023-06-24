// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/util/builders/custom_alret_dialoge.dart';
import '../../../account/presentation/providers/account.dart';

import '../providers/for_doctor_screen_state_provider.dart';
import '../pages/prediction_screen.dart';

class AddAndShowResultButton extends StatelessWidget {
  const AddAndShowResultButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForDoctorScreenState>(context);
    final leftPadding = (MediaQuery.of(context).size.width - 40 - 70) / 2;

    return Align(
      child: Row(
        children: [
          SizedBox(width: leftPadding),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xff0079ff).withOpacity(1),
                  const Color(0xff313bbd).withOpacity(1),
                  const Color(0xff521191).withOpacity(1),
                  const Color(0xff4d1798).withOpacity(1),
                  const Color(0xff5f0080).withOpacity(1)
                ],
                stops: const [0, 0.5, 0.862, 0.897, 1],
              ),
            ),
            child: IconButton(
              tooltip: provider.isBoxShown
                  ? "hide image box above"
                  : "show image box",
              onPressed: provider.togoleBoxShown,
              padding: EdgeInsets.zero,
              icon: const AddIcon()
                  .animate(target: provider.isBoxShown ? 1 : 0)
                  .rotate(begin: 0, end: -1.043 * 3, duration: 50.ms),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () async {
              final user = await Provider.of<Account>(context, listen: false)
                  .getUserInfo();
              if (user == null || user.userType != "Doctor") {
                showCustomAlretDialog(
                  context: context,
                  title: "Sorry",
                  titleColor: Colors.red,
                  content: "This feature only available to Doctors.",
                );
                return;
              }

              final isXray = await selectImageTypeDialog(context);
              if (isXray == null) {
                return;
              }

              Navigator.of(context)
                  .pushNamed(PredictionScreen.routName, arguments: isXray);
            },
            child: const Text(
              "Show Result",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
              .animate(
                  target: provider.fileImage != null ||
                          provider.networkImage != null
                      ? 1
                      : 0)
              .slideX(begin: 2, end: 0, duration: 500.ms)
              .fade(begin: 0, end: 1)
        ],
      ),
    );
    //.moveY(begin: -200, end: 0, duration: 50.ms);
  }
}

class AddIcon extends StatelessWidget {
  const AddIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: const [
        CustomLine(),
        CustomLine(isHorizantal: false),
      ],
    );
  }
}

class CustomLine extends StatelessWidget {
  const CustomLine({super.key, this.isHorizantal = true});

  final bool isHorizantal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isHorizantal ? 40 : 9,
      height: isHorizantal ? 9 : 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

Future<bool?> selectImageTypeDialog(BuildContext context) {
  void selectChoice(bool isXray) {
    Navigator.of(context).pop(isXray);
  }

  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: RadioList(onSellected: selectChoice),
      );
    },
  );
}

class RadioList extends StatefulWidget {
  const RadioList({super.key, required this.onSellected});

  final void Function(bool isXray) onSellected;

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  bool _isXray = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Select Medical Image Type",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          RadioListTile<bool>(
            title: const Text('X-Ray Image'),
            value: true,
            groupValue: _isXray,
            onChanged: (value) {
              setState(() {
                _isXray = true;
              });
            },
          ),
          RadioListTile(
            title: const Text('Histology Image'),
            value: false,
            groupValue: _isXray,
            onChanged: (value) {
              setState(() {
                _isXray = false;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                widget.onSellected(_isXray);
              },
              child: const Text("Select")),
        ],
      ),
    );
  }
}
