import 'package:flutter/material.dart';
import 'package:game_app/core/widget/custom_elevated_button.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class PlayingPhaseWidget extends StatelessWidget {
  const PlayingPhaseWidget({
    super.key,
    required this.stopWatchTimer,
    required this.isPaused,
    required this.onPauseResume,
    required this.onEndTurn,
  });

  final StopWatchTimer stopWatchTimer;
  final bool isPaused;
  final VoidCallback onPauseResume;
  final VoidCallback onEndTurn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<int>(
          stream: stopWatchTimer.rawTime,
          initialData: stopWatchTimer.rawTime.value,
          builder: (context, snap) {
            final value = snap.data!;
            final displayTime = StopWatchTimer.getDisplayTime(
              value,
              hours: false,
              milliSecond: false,
            );

            return Text(
              displayTime,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomElevatedButton(
                text: isPaused ? 'استمرار' : 'إيقاف',
                onPressed: onPauseResume,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomElevatedButton(
                text: 'إنهاء الدور',
                backgroundColor: Colors.red,
                onPressed: onEndTurn,
              ),
            ),
          ],
        ),
      ],
    );
  }
}