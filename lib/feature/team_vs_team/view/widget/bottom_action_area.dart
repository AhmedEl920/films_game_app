import 'package:flutter/material.dart';
import 'package:game_app/core/widget/custom_elevated_button.dart';
import 'package:game_app/feature/team_vs_team/view/game_screen.dart';
import 'package:game_app/feature/team_vs_team/view/widget/ended_phase_widget.dart';
import 'package:game_app/feature/team_vs_team/view/widget/playing_phase_widget.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class BottomActionArea extends StatelessWidget {
  const BottomActionArea({
    super.key,
    required this.currentPhase,
    required this.onStartTimer,
    required this.stopWatchTimer,
    required this.isPaused,
    required this.onPauseResume,
    required this.onEndTurn,
    required this.movieChecked,
    required this.seriesChecked,
    required this.playChecked,
    required this.onMovieChanged,
    required this.onSeriesChanged,
    required this.onPlayChanged,
    required this.onNext,
  });

  final GamePhase currentPhase;
  final VoidCallback onStartTimer;
  final StopWatchTimer stopWatchTimer;
  final bool isPaused;
  final VoidCallback onPauseResume;
  final VoidCallback onEndTurn;

  final bool movieChecked;
  final bool seriesChecked;
  final bool playChecked;

  final ValueChanged<bool?> onMovieChanged;
  final ValueChanged<bool?> onSeriesChanged;
  final ValueChanged<bool?> onPlayChanged;

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    switch (currentPhase) {
      case GamePhase.initial:
        return CustomElevatedButton(text: 'ابدأ', onPressed: onStartTimer);

      case GamePhase.playing:
        return PlayingPhaseWidget(
          stopWatchTimer: stopWatchTimer,
          isPaused: isPaused,
          onPauseResume: onPauseResume,
          onEndTurn: onEndTurn,
        );

      case GamePhase.ended:
        return EndedPhaseWidget(
          movieChecked: movieChecked,
          seriesChecked: seriesChecked,
          playChecked: playChecked,
          onMovieChanged: onMovieChanged,
          onSeriesChanged: onSeriesChanged,
          onPlayChanged: onPlayChanged,
          onNext: onNext,
        );
    }
  }
}
