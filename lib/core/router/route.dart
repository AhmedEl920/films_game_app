import 'package:flutter/material.dart';
import 'package:game_app/core/router/app_routes.dart';
import 'package:game_app/core/router/router_transitions.dart';
import 'package:game_app/feature/home/view/home_screen.dart';
import 'package:game_app/feature/splash/splash_page.dart';
import 'package:game_app/feature/team_vs_team/view/team_setup_screen.dart';
import 'package:game_app/feature/team_vs_team/view/game_screen.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashRoute:
        return RouterTransitions.buildHorizontal(const SplashPage());
      case AppRoutes.homeRoute:
        return RouterTransitions.buildHorizontal(const HomeScreen());
      case AppRoutes.teamSetupRoute:
        return RouterTransitions.buildHorizontal(const TeamSetupScreen());
      case AppRoutes.gameRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        return RouterTransitions.buildHorizontal(
          GameScreen(
            team1Name: args?['team1Name'] ?? '',
            team2Name: args?['team2Name'] ?? '',
            durationSeconds: args?['durationSeconds'] ?? 90,
          ),
        );

      default:
        return null;
    }
  }
}
