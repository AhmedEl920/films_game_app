import 'package:flutter/material.dart';
import 'package:game_app/core/router/app_routes.dart';
import 'package:game_app/feature/home/view/widget/custom_drawer.dart';
import 'package:game_app/feature/home/view/widget/home_option_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('افلام من غير كلام'), leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),),
        drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            HomeOptionCard(
              title: "فريق ضد فريق",
              subtitle: "تنافس بين فريقين في تحديات ممتعة",
              icon: Icons.groups,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.teamSetupRoute);
              },
            ),

            const SizedBox(height: 16),

            HomeOptionCard(
              title: "فرد ضد مجموعة",
              subtitle: "شخص واحد يواجه فريق كامل",
              icon: Icons.person,
              onTap: () {},
            ),

            const SizedBox(height: 16),

            HomeOptionCard(
              title: "خمن ماذا معي",
              subtitle: "لعبة التخمين والتحدي",
              icon: Icons.help_outline,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

