import 'package:flutter/material.dart';
import 'package:tell_me_something/theme/colors.dart';

class SideBarButton extends StatelessWidget {
  final bool isCollapsed;
  final IconData icon;
  final String text;
  const SideBarButton({
    super.key,
    required this.isCollapsed,
    required this.icon,
    required this.text, 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Icon(icon, color: AppColors.iconGrey, size: 24),
        ),
        isCollapsed
            ? const SizedBox()
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textGrey,
                ),
              ),
      ],
    );
  }
}
