import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Border? border;

  const SocialLoginButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = AppTheme.surfaceLight,
    this.textColor = AppTheme.textDark,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: border ?? Border.all(color: AppTheme.textGrey.withOpacity(0.2)),
        boxShadow: [
          if (backgroundColor == AppTheme.surfaceLight)
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
