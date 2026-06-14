
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DurationSelectorWidget extends StatelessWidget {
  const DurationSelectorWidget({
    super.key,
    required this.selectedDurationSeconds,
    required this.onDurationSelected,
  });

  final int selectedDurationSeconds;
  final ValueChanged<int> onDurationSelected;

  @override
  Widget build(BuildContext context) {
    final durations = [
      ('دقيقة', 60),
      ('دقيقة ونص', 90),
      ('دقيقتين', 120),
      ('٣ دقائق', 180),
    ];

    return Row(
      children: durations.map((duration) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              label: Center(
                child: Text(
                  duration.$1,
                  style:  TextStyle(fontSize: 12.sp,fontFamily: 'Amiri'),
                ),
              ),
              selected: selectedDurationSeconds == duration.$2,
              onSelected: (selected) {
                if (selected) {
                  onDurationSelected(duration.$2);
                }
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}