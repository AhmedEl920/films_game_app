
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_app/core/widget/custom_text_form.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({
    super.key,
    required this.teamTitle,
    required this.teamNameController,
  });

  final String teamTitle;
  final TextEditingController teamNameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          teamTitle,
          style: TextStyle(
            color: Theme.of(context).textTheme.titleMedium?.color,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        CustomTextForm(
          controller: teamNameController,
          hintText: 'أدخل اسم الفريق',
          prefixIcon: const Icon(Icons.group),
        ),
      ],
    );
  }
}