import 'package:flutter/material.dart';

class NoteButton extends StatelessWidget {
  const NoteButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          fixedSize: const MaterialStatePropertyAll(Size(70, 70)),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000))),
          padding: const MaterialStatePropertyAll(EdgeInsets.all(8.0)),
        ),
        child: Icon(icon, size: 40),
      ),
    );
  }
}
