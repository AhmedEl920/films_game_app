import 'package:flutter/material.dart';
import 'package:game_app/core/constant/app_color.dart';
import 'package:game_app/core/widget/custom_elevated_button.dart';
import 'package:game_app/feature/team_vs_team/view/widget/game_rules_widget.dart';

class CustomDialogWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomDialogWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.accent.withOpacity(.2),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           GameRulesWidget(),
            CustomElevatedButton(text: buttonText, onPressed: onPressed),
          ],
        ),
      ),
    );
  }
}
