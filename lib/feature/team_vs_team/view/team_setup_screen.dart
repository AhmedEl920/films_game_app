import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_app/core/widget/custom_elevated_button.dart';
import 'package:game_app/core/router/app_routes.dart';

class TeamSetupScreen extends StatefulWidget {
  const TeamSetupScreen({super.key});

  @override
  State<TeamSetupScreen> createState() => _TeamSetupScreenState();
}

class _TeamSetupScreenState extends State<TeamSetupScreen> {
  final TextEditingController team1NameController = TextEditingController();
  final TextEditingController team2NameController = TextEditingController();

  @override
  void dispose() {
    team1NameController.dispose();
    team2NameController.dispose();
    super.dispose();
  }

  void _startGame() {
    // You can validate and proceed to the next screen here
    // Example: collecting the string values from controllers
    String team1 = team1NameController.text;
    String team2 = team2NameController.text;

    print("Team 1: $team1");
    print("Team 2: $team2");

    Navigator.pushReplacementNamed(
      context, 
      AppRoutes.gameRoute,
      arguments: {
        'team1Name': team1,
        'team2Name': team2,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إعداد تيم ضد تيم')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTeamSection(
                teamTitle: "الفريق الأول",
                teamNameController: team1NameController,
              ),

              const SizedBox(height: 24),
              const Divider(thickness: 2),
              const SizedBox(height: 24),

              _buildTeamSection(
                teamTitle: "الفريق الثاني",
                teamNameController: team2NameController,
              ),

              const SizedBox(height: 32),
              CustomElevatedButton(text: 'ابدأ اللعبة', onPressed: _startGame),
              // ElevatedButton(
              //   onPressed: _startGame,
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(vertical: 16),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              //   child: const Text('ابدأ اللعبة', style: TextStyle(fontSize: 18)),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamSection({
    required String teamTitle,
    required TextEditingController teamNameController,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          teamTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: teamNameController,
          decoration: const InputDecoration(
            labelText: 'اسم الفريق',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.group),
          ),
        ),
      ],
    );
  }
}
