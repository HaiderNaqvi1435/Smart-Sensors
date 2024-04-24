import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget implements PreferredSizeWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      color: Colors.grey,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
