import 'package:flutter/material.dart';
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
    final provider = Provider.of<ForDoctorScreenState>(context);
    final formKey = provider.formKey;

    return Form(
      key: formKey,
      child: TextFormField(
        keyboardType: TextInputType.url,
        autocorrect: false,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 20, right: 5, top: 5, bottom: 5),
          hintText: 'Or Past a Link here',
          hintStyle:
              const TextStyle(color: Color.fromRGBO(112, 112, 112, 0.85)),
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
          suffixIconColor: Colors.white,
          suffixIconConstraints: const BoxConstraints(maxHeight: 30),
          suffixIcon: provider.isTextFieldIconShowen
              ? SizedBox(
                  width: 30,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        provider.setTextFieldIconShowen(false);
                        formKey.currentState!.reset();
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
          value = value.trim();
          if (value.isEmpty) {
            provider.setTextFieldIconShowen(false);
            formKey.currentState!.reset();
            return;
          } else {
            provider.setTextFieldIconShowen(true);
          }
          final error = await validateImageLink(value);
          if (error != null) {
            setState(() {
              _linkError = error;
            });
            formKey.currentState!.validate();
            return;
          }

          provider.setNetworkImage(value);
        },
        validator: (value) {
          return _linkError;
        },
      ),
    );
  }
}
