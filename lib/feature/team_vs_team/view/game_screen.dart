import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:game_app/core/widget/custom_elevated_button.dart';
import 'package:game_app/feature/team_vs_team/data/media_repository.dart';
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
        appBar: AppBar(title: const Text('افلام من غير كلام')),
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
                    padding: const EdgeInsets.all(16.0),
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
                        const SizedBox(height: 24),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'دور : ${state.currentTeamName}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    FlipCard(
                                      key: _cardKey,
                                      front: Container(
                                        width: 250,
                                        height: 350,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.deepPurple,
                                              Colors.indigo,
                                            ],
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: Image.asset(
                                            state.isTeam1Turn
                                                ? 'assets/images/card4.png'
                                                : 'assets/images/card3.png',
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
                                        width: 250,
                                        height: 350,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 10,
                                              offset: Offset(0, 5),
                                              color: Colors.black26,
                                            ),
                                          ],
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
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                                                                fontSize: 16,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                                                                fontSize: 16,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                                                                fontSize: 16,
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
                                              'assets/images/card.png',
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
                                const SizedBox(height: 32),

                                // Bottom Action Area
                                _buildBottomActionArea(context),
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'مبروك!',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'الفريق الفائز: ${state.winnerName}',
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'النتيجة: ${state.team1Score} - ${state.team2Score}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 40),
                    CustomElevatedButton(
                      text: 'لعبة جديدة',
                      onPressed: () {
                        context.read<GameCubit>().initGame(
                          state.team1Name,
                          state.team2Name,
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildBottomActionArea(BuildContext context) {
    if (_currentPhase == GamePhase.initial) {
      return CustomElevatedButton(text: 'ابدأ', onPressed: _startTimer);
    } else if (_currentPhase == GamePhase.playing) {
      return Column(
        children: [
          StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: _stopWatchTimer.rawTime.value,
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
                  text: _isPaused ? 'استمرار' : 'إيقاف',
                  onPressed: () {
                    if (_isPaused) {
                      _stopWatchTimer.onStartTimer();
                    } else {
                      _stopWatchTimer.onStopTimer();
                    }
                    setState(() {
                      _isPaused = !_isPaused;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomElevatedButton(
                  text: 'إنهاء الدور',
                  backgroundColor: Colors.red,
                  onPressed: () {
                    _stopWatchTimer.onStopTimer();
                    setState(() {
                      _currentPhase = GamePhase.ended;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      // Ended phase
      return Column(
        children: [
          const Text(
            'اختر ما تم تمثيله',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text('الفيلم', style: TextStyle(fontSize: 12)),
                  value: _movieChecked,
                  onChanged: (val) {
                    setState(() => _movieChecked = val ?? false);
                  },
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: const Text('المسلسل', style: TextStyle(fontSize: 12)),
                  value: _seriesChecked,
                  onChanged: (val) {
                    setState(() => _seriesChecked = val ?? false);
                  },
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: const Text('المسرحية', style: TextStyle(fontSize: 12)),
                  value: _playChecked,
                  onChanged: (val) {
                    setState(() => _playChecked = val ?? false);
                  },
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          CustomElevatedButton(
            text: 'التالي',
            onPressed: () => _nextTurn(context),
          ),
        ],
      );
    }
  }
}
