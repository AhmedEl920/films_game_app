import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/feature/team_vs_team/data/media_repository.dart';
import 'package:game_app/feature/team_vs_team/view_model/game_cubit.dart';

class GameScreen extends StatelessWidget {
  final String team1Name;
  final String team2Name;

  const GameScreen({
    super.key,
    required this.team1Name,
    required this.team2Name,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(MediaRepository())..initGame(team1Name, team2Name),
      child: Scaffold(
        appBar: AppBar(title: const Text('افلام من غير كلام')),
        body: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            if (state is GameLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GameError) {
              return Center(child: Text("Error: ${state.message}"));
            } else if (state is GameLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'دور فريق: ${state.currentTeamName}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 32),
                      FlipCard(
                        front: Container(
                          width: 250,
                          height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [Colors.deepPurple, Colors.indigo],
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/images/card1.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Center(
                                child: Icon(Icons.movie_creation, color: Colors.white, size: 100),
                              ),
                            ),
                          ),
                        ),
                        back: Container(
                          width: 250,
                          height: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black, width: 2),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.movie, color: Colors.black),
                                        const SizedBox(width: 8),
                                        Expanded(child: Text(state.movie.name, style: const TextStyle(color: Colors.black, fontSize: 16))),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.tv, color: Colors.black),
                                        const SizedBox(width: 8),
                                        Expanded(child: Text(state.series.name, style: const TextStyle(color: Colors.black, fontSize: 16))),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.theater_comedy, color: Colors.black),
                                        const SizedBox(width: 8),
                                        Expanded(child: Text(state.play.name, style: const TextStyle(color: Colors.black, fontSize: 16))),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Align(
                                  alignment: Alignment.bottomRight,
                                  child: RotatedBox(
                                    quarterTurns: 2,
                                    child: Text(
                                      "A",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
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
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          context.read<GameCubit>().nextTurn();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: const Text('التالي', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
