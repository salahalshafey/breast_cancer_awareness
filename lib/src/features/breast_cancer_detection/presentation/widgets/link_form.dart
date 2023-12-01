import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/util/functions/general_functions.dart';
import '../providers/for_doctor_screen_state_provider.dart';

class LinkForm extends StatefulWidget {
  const LinkForm({super.key});

  @override
  State<LinkForm> createState() => _LinkFormState();
}

class _LinkFormState extends State<LinkForm> {
  String? _linkError;

  @override
  Widget build(BuildContext context) {
    final forDoctorScreenState = Provider.of<ForDoctorScreenState>(context);
    final formKey = forDoctorScreenState.formKey;

    return Form(
      key: formKey,
      child: TextFormField(
        keyboardType: TextInputType.url,
        autocorrect: false,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.deny(" "),
        ],
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 20, right: 5, top: 5, bottom: 5),
          hintText: 'Or Paste a Link here',
          hintStyle: const TextStyle(
            color: Color.fromRGBO(112, 112, 112, 0.85),
          ),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(22),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black26,
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(22),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(22),
          ),
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white70
              : Colors.white,
          prefixIconConstraints: const BoxConstraints(maxWidth: 30),
          prefixIcon: forDoctorScreenState.isTextFieldLoadinShowen
              ? const Center(
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.black45,
                    ),
                  ),
                )
              : null,
          suffixIconConstraints: const BoxConstraints(maxHeight: 20),
          suffixIcon: forDoctorScreenState.isTextFieldIconShowen
              ? SizedBox(
                  width: 30,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        forDoctorScreenState.resetBox();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.black45,
                        size: 20,
                      ),
                    ),
                  ),
                )
              : null,
        ),
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        onChanged: (value) async {
          forDoctorScreenState.setBoxNotRestted();

          value = value.trim();
          if (value.isEmpty) {
            forDoctorScreenState.resetBox();
            return;
          } else {
            forDoctorScreenState.setTextFieldIconShowen(true);
          }

          forDoctorScreenState.setTextFieldLoading(true);
          final error = await validateImageLink(value);
          forDoctorScreenState.setTextFieldLoading(false);

          if (forDoctorScreenState.isBoxResetted) {
            return;
          }

          if (error != null) {
            setState(() {
              _linkError = error;
            });
            formKey.currentState!.validate();
            return;
          }

          forDoctorScreenState.setNetworkImage(value);
        },
        validator: (value) {
          return _linkError;
        },
      ),
    );
  }
}
