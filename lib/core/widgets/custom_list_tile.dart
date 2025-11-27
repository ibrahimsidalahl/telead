import 'package:flutter/material.dart';

import '../styles/app_style.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final Widget trailing;

  const CustomListTile(
      {super.key,
        required this.leading,
        required this.title,
        required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leading,
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: AppStyles.styleBlack20(context),
          ),
        ),
        trailing,
      ],
    );
  }
}
