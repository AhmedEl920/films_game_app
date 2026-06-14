import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_app/core/constant/app_color.dart';
import 'package:game_app/core/constant/app_image.dart';
import 'package:game_app/feature/team_vs_team/view/widget/bottom_action_area.dart';
import 'package:game_app/feature/team_vs_team/view/widget/custom_dialog_widget.dart';
import 'package:game_app/feature/team_vs_team/view/widget/custom_winer_widget.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:game_app/core/widget/custom_elevated_button.dart';
import 'package:game_app/feature/team_vs_team/data/repo/media_repository.dart';
import 'package:game_app/feature/team_vs_team/view_model/game_cubit.dart';
import 'package:game_app/feature/team_vs_team/view/widget/lucky_card_widget.dart';

enum GamePhase { initial, playing, ended }

class GameScreen extends StatefulWidget {
  final String team1Name;
  final String team2Name;
  final int durationSeconds;

  const GameScreen({
    super.key,
    required this.team1Name,
    required this.team2Name,
    required this.durationSeconds,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late StopWatchTimer _stopWatchTimer;
  GamePhase _currentPhase = GamePhase.initial;

  bool _movieChecked = false;
  bool _seriesChecked = false;
  bool _playChecked = false;
  bool _isPaused = false;
  bool _showLuckyCard = false;

  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(
        widget.durationSeconds,
      ),
      onEnded: () {
        if (mounted) {
          setState(() {
            _currentPhase = GamePhase.ended;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _currentPhase = GamePhase.playing;
      _isPaused = false;
    });
    _stopWatchTimer.onStartTimer();
  }

  void _nextTurn(BuildContext context) {
    int points = 0;
    if (_movieChecked) points++;
    if (_seriesChecked) points++;
    if (_playChecked) points++;

    if (points > 0) {
      context.read<GameCubit>().addPoints(points);
    }

    context.read<GameCubit>().nextTurn();

    setState(() {
      _currentPhase = GamePhase.initial;
      _movieChecked = false;
      _seriesChecked = false;
      _playChecked = false;
      _isPaused = false;
      _showLuckyCard = false;
      _stopWatchTimer.onResetTimer();
    });

    if (_cardKey.currentState != null && !_cardKey.currentState!.isFront) {
      _cardKey.currentState!.toggleCard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GameCubit(MediaRepository())
            ..initGame(widget.team1Name, widget.team2Name),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('افلام من غير كلام'),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialogWidget(
                    buttonText: 'الغاء',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              icon: Icon(Icons.rocket_launch),
            ),
          ],
        ),
        body: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            if (state is GameLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GameError) {
              return Center(child: Text("Error: ${state.message}"));
            } else if (state is GameLoaded) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        // Scores Header
                        Row(
                          children: [
                            Text(
                              '${state.team1Name}: ${state.team1Score}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: state.isTeam1Turn
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${state.team2Name}: ${state.team2Score}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: !state.isTeam1Turn
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  'دور : ${state.currentTeamName}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Amiri',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    FlipCard(
                                      key: _cardKey,
                                      front: Container(
                                        width: 300.w,
                                        height: 450.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: Image.asset(
                                            state.isTeam1Turn
                                                ? AppImage.cardImage4
                                                : AppImage.cardImage3,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Center(
                                                      child: Icon(
                                                        Icons.movie_creation,
                                                        color: Colors.white,
                                                        size: 100,
                                                      ),
                                                    ),
                                          ),
                                        ),
                                      ),
                                      back: Container(
                                        width: 300.w,
                                        height: 450.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.accent.withOpacity(
                                            0.9,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            children: [
                                              const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "A",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontFamily: 'Amiri',
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons.movie,
                                                        color: Colors.black,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Text(
                                                          state.movie.name,
                                                          style:
                                                              const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Amiri',
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.tv,
                                                        color: Colors.black,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Text(
                                                          state.series.name,
                                                          style:
                                                              const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Amiri',
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.theater_comedy,
                                                        color: Colors.black,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Text(
                                                          state.play.name,
                                                          style:
                                                              const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'Amiri',
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              const Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: RotatedBox(
                                                  quarterTurns: 2,
                                                  child: Text(
                                                    "A",
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontFamily: 'Amiri',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (state.hasLuckyCard)
                                      Positioned(
                                        bottom: 10.h,
                                        left: 70.w,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _showLuckyCard = true;
                                            });
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              99,
                                            ),
                                            child: Image.asset(
                                              AppImage.cardImage,
                                              width: 60.w,
                                              height: 60.h,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => const Icon(
                                                    Icons.card_giftcard,
                                                    size: 50,
                                                    color: Colors.orange,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                // Bottom Action Area
                                BottomActionArea(
                                  currentPhase: _currentPhase,
                                  onStartTimer: _startTimer,
                                  stopWatchTimer: _stopWatchTimer,
                                  isPaused: _isPaused,
                                  onPauseResume: () {
                                    if (_isPaused) {
                                      _stopWatchTimer.onStartTimer();
                                    } else {
                                      _stopWatchTimer.onStopTimer();
                                    }

                                    setState(() {
                                      _isPaused = !_isPaused;
                                    });
                                  },
                                  onEndTurn: () {
                                    _stopWatchTimer.onStopTimer();

                                    setState(() {
                                      _currentPhase = GamePhase.ended;
                                    });
                                  },
                                  movieChecked: _movieChecked,
                                  seriesChecked: _seriesChecked,
                                  playChecked: _playChecked,
                                  onMovieChanged: (value) {
                                    setState(
                                      () => _movieChecked = value ?? false,
                                    );
                                  },
                                  onSeriesChanged: (value) {
                                    setState(
                                      () => _seriesChecked = value ?? false,
                                    );
                                  },
                                  onPlayChanged: (value) {
                                    setState(
                                      () => _playChecked = value ?? false,
                                    );
                                  },
                                  onNext: () => _nextTurn(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_showLuckyCard)
                    Positioned.fill(
                      child: LuckyCardWidget(
                        luckyCardText: state.luckyCardText,
                        onClose: () {
                          setState(() {
                            _showLuckyCard = false;
                          });
                        },
                      ),
                    ),
                ],
              );
            } else if (state is GameFinished) {
              return CustomWinerWidget(
                team1Score: state.team1Score,
                team2Score: state.team2Score,
                winnerName: state.winnerName,
                team1Name: state.team1Name,
                team2Name: state.team2Name,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
