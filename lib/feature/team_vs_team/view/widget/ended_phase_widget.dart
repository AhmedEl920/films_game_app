import 'package:flutter/material.dart';
import 'package:game_app/core/widget/custom_elevated_button.dart';

class EndedPhaseWidget extends StatelessWidget {
  const EndedPhaseWidget({
    super.key,
    required this.movieChecked,
    required this.seriesChecked,
    required this.playChecked,
    required this.onMovieChanged,
    required this.onSeriesChanged,
    required this.onPlayChanged,
    required this.onNext,
  });

  final bool movieChecked;
  final bool seriesChecked;
  final bool playChecked;

  final ValueChanged<bool?> onMovieChanged;
  final ValueChanged<bool?> onSeriesChanged;
  final ValueChanged<bool?> onPlayChanged;

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'اختر ما تم تمثيله',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: CheckboxListTile(
                title: const Text('الفيلم', style: TextStyle(fontSize: 12)),
                value: movieChecked,
                onChanged: onMovieChanged,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                title: const Text('المسلسل', style: TextStyle(fontSize: 12)),
                value: seriesChecked,
                onChanged: onSeriesChanged,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                title: const Text('المسرحية', style: TextStyle(fontSize: 12)),
                value: playChecked,
                onChanged: onPlayChanged,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        CustomElevatedButton(text: 'التالي', onPressed: onNext),
      ],
    );
  }
}
