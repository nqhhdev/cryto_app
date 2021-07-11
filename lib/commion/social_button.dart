import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onPressed;

  const SocialButton({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: FaIcon(
        icon,
        size: 16.0,
      ),
      style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          primary: Colors.white,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(18.0)),
    );
  }
}
