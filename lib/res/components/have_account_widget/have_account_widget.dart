import 'package:smart_sensors/res/components/default_text/default_text.dart';
import 'package:flutter/material.dart';

import '../../colors/app_colors/app_colors.dart';

class HaveAccountWidget extends StatelessWidget {
  final bool isLoginPage;
  final VoidCallback onPressed;
  const HaveAccountWidget({
    super.key,
    required this.isLoginPage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      DefaultText(
        text:
            isLoginPage ? "Don't have an account?" : "Already have an account?",
        fontSize: 9,
      ),
      TextButton(
        onPressed: onPressed,
        child: Text(
          isLoginPage ? 'Sign up' : "Login",
          style: const TextStyle(
              fontSize: 9,
              color: AppColors.linearColor1,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.linearColor1),
        ),
      )
    ]);
  }
}
