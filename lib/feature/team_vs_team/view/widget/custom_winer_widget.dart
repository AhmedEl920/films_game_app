
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/widget/custom_elevated_button.dart';
import 'package:game_app/feature/team_vs_team/view_model/game_cubit.dart';

class CustomWinerWidget extends StatelessWidget {
  final String winnerName, team1Name, team2Name;
  final int team1Score, team2Score;
  const CustomWinerWidget({
    super.key,
    required this.team1Score,
    required this.team2Score,
    required this.winnerName,
    required this.team1Name,
    required this.team2Name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/congratulations_images.webp'),
          const SizedBox(height: 20),
          const Text(
            'مبروك!',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              fontFamily: 'Amiri'
            ), 
          ),
          const SizedBox(height: 20),
          Text(
            'الفريق الفائز: $winnerName',
            style: const TextStyle(fontSize: 30,fontFamily: 'Amiri',color: Colors.black),
          ),
          const SizedBox(height: 20),
          Text(
            'النتيجة: $team1Score - $team2Score',
            style: const TextStyle(fontSize: 24,fontFamily: 'Amiri',),
          ),
          const SizedBox(height: 40),
          CustomElevatedButton(
            text: 'لعبة جديدة',
            onPressed: () {
              context.read<GameCubit>().initGame(team1Name, team2Name);
            },
          ),
        ],
      ),
    );
  }
}
