import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/feature/team_vs_team/data/model/media_model.dart';
import 'package:game_app/feature/team_vs_team/data/repo/media_repository.dart';

abstract class GameState {}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameLoaded extends GameState {
  final MediaItem movie;
  final MediaItem series;
  final MediaItem play;
  final String currentTeamName;
  final String team1Name;
  final String team2Name;
  final bool isTeam1Turn;
  final int team1Score;
  final int team2Score;
  final bool hasLuckyCard;
  final String luckyCardText;

  GameLoaded({
    required this.movie,
    required this.series,
    required this.play,
    required this.currentTeamName,
    required this.team1Name,
    required this.team2Name,
    required this.isTeam1Turn,
    required this.team1Score,
    required this.team2Score,
    required this.hasLuckyCard,
    required this.luckyCardText,
  });
}

class GameError extends GameState {
  final String message;
  GameError(this.message);
}

class GameFinished extends GameState {
  final String winnerName;
  final String team1Name;
  final String team2Name;
  final int team1Score;
  final int team2Score;

  GameFinished({
    required this.winnerName,
    required this.team1Name,
    required this.team2Name,
    required this.team1Score,
    required this.team2Score,
  });
}

class GameCubit extends Cubit<GameState> {
  final MediaRepository repository;
  String team1Name = '';
  String team2Name = '';
  bool isTeam1Turn = true;
  int team1Score = 0;
  int team2Score = 0;

  GameCubit(this.repository) : super(GameInitial());

  void initGame(String t1, String t2) async {
    emit(GameLoading());
    try {
      team1Name = t1.isEmpty ? 'الفريق الأول' : t1;
      team2Name = t2.isEmpty ? 'الفريق الثاني' : t2;
      isTeam1Turn = true;
      team1Score = 0;
      team2Score = 0;
      
      await repository.loadData();
      _generateNewRound();
    } catch (e) {
      emit(GameError(e.toString()));
    }
  }

  void nextTurn() {
    if (state is GameLoaded) {
      if (!isTeam1Turn) {
        if (team1Score >= 20 || team2Score >= 20) {
          if (team1Score > team2Score) {
            emit(GameFinished(
              winnerName: team1Name,
              team1Name: team1Name,
              team2Name: team2Name,
              team1Score: team1Score,
              team2Score: team2Score,
            ));
            return;
          } else if (team2Score > team1Score) {
            emit(GameFinished(
              winnerName: team2Name,
              team1Name: team1Name,
              team2Name: team2Name,
              team1Score: team1Score,
              team2Score: team2Score,
            ));
            return;
          }
        }
      }

      isTeam1Turn = !isTeam1Turn;
      _generateNewRound();
    }
  }

  void addPoints(int points) {
    if (isTeam1Turn) {
      team1Score += points;
    } else {
      team2Score += points;
    }
  }

  void _generateNewRound() {
    final bool hasLuckyCard = repository.getRandomMovie().name.isNotEmpty && Random().nextInt(100) < 40; // 40% chance
    emit(GameLoaded(
      movie: repository.getRandomMovie(),
      series: repository.getRandomSeries(),
      play: repository.getRandomPlay(),
      currentTeamName: isTeam1Turn ? team1Name : team2Name,
      team1Name: team1Name,
      team2Name: team2Name,
      isTeam1Turn: isTeam1Turn,
      team1Score: team1Score,
      team2Score: team2Score,
      hasLuckyCard: hasLuckyCard,
      luckyCardText: hasLuckyCard ? repository.getRandomLuckyCard() : "",
    ));
  }
}
