import 'package:flutter/material.dart';
import 'package:game_app/core/Service/sound_service.dart';
import 'package:game_app/core/widget/custom_elevated_button.dart';
import 'package:game_app/core/router/app_routes.dart';
import 'package:game_app/feature/team_vs_team/view/widget/duration_selector_widget.dart';
import 'package:game_app/feature/team_vs_team/view/widget/game_rules_widget.dart';
import 'package:game_app/feature/team_vs_team/view/widget/team_section.dart';

class TeamSetupScreen extends StatefulWidget {
  const TeamSetupScreen({super.key});

  @override
  State<TeamSetupScreen> createState() => _TeamSetupScreenState();
}

class _TeamSetupScreenState extends State<TeamSetupScreen> {
  final TextEditingController team1NameController = TextEditingController();
  final TextEditingController team2NameController = TextEditingController();

  int selectedDurationSeconds = 90; // 1.5 minutes default

  @override
  void dispose() {
    team1NameController.dispose();
    team2NameController.dispose();
    super.dispose();
  }

  Future<void> _startGame() async {
    // You can validate and proceed to the next screen here
    // Example: collecting the string values from controllers
    String team1 = team1NameController.text;
    String team2 = team2NameController.text;
    await SoundService.playClick();

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.gameRoute,
      arguments: {
        'team1Name': team1,
        'team2Name': team2,
        'durationSeconds': selectedDurationSeconds,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعداد تيم ضد تيم')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TeamSection(
                teamTitle: "الفريق الأول",
                teamNameController: team1NameController,
              ),
              const SizedBox(height: 8),

              const Divider(thickness: 1),
              TeamSection(
                teamTitle: "الفريق الثاني",
                teamNameController: team2NameController,
              ),

              const SizedBox(height: 12),
              Text(
                'مدة التمثيل:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleMedium?.color,
                  fontFamily: 'Amiri',
                ),
              ),
              const SizedBox(height: 8),
              DurationSelectorWidget(
                selectedDurationSeconds: selectedDurationSeconds,
                onDurationSelected: (seconds) {
                  setState(() {
                    selectedDurationSeconds = seconds;
                  });
                },
              ),

              const SizedBox(height: 16),
              CustomElevatedButton(text: 'ابدأ اللعبة', onPressed: _startGame,),
              const SizedBox(height: 16),
              GameRulesWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
