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

  int selectedDurationSeconds = 90; // 1.5 minutes default

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
        'durationSeconds': selectedDurationSeconds,
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

              const SizedBox(height: 24),
              const Text(
                'قواعد اللعبة:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('١. يتم تقسيم اللاعبين إلى فريقين.'),
              const Text('٢. يقوم أحد اللاعبين بتمثيل اسم فيلم بدون كلام.'),
              const Text('٣. يجب على فريقه تخمين الفيلم قبل انتهاء الوقت.'),
              const Text('٤. الفريق الذي يجمع أكبر عدد من النقاط هو الفائز.'),

              const SizedBox(height: 24),
              const Text(
                'مدة التمثيل:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      label: const Center(child: Text('دقيقة', style: TextStyle(fontSize: 12))),
                      selected: selectedDurationSeconds == 60,
                      onSelected: (selected) {
                        if (selected) setState(() => selectedDurationSeconds = 60);
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: ChoiceChip(
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      label: const Center(child: Text('١.٥ دقيقة', style: TextStyle(fontSize: 12))),
                      selected: selectedDurationSeconds == 90,
                      onSelected: (selected) {
                        if (selected) setState(() => selectedDurationSeconds = 90);
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: ChoiceChip(
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      label: const Center(child: Text('دقيقتين', style: TextStyle(fontSize: 12))),
                      selected: selectedDurationSeconds == 120,
                      onSelected: (selected) {
                        if (selected) setState(() => selectedDurationSeconds = 120);
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: ChoiceChip(
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      label: const Center(child: Text('٣ دقائق', style: TextStyle(fontSize: 12))),
                      selected: selectedDurationSeconds == 180,
                      onSelected: (selected) {
                        if (selected) setState(() => selectedDurationSeconds = 180);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              CustomElevatedButton(text: 'ابدأ اللعبة', onPressed: _startGame),
      
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
