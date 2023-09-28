import 'package:flutter/material.dart';

class CloseIcon extends StatelessWidget {
  final VoidCallback onTap;
  const CloseIcon({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const CircleAvatar(
        radius: 10,
        backgroundColor: Colors.black,
        child: Icon(
          Icons.close_rounded,
          color: Colors.white,
          size: 12,
        ),
      ),
    );
  }
}
