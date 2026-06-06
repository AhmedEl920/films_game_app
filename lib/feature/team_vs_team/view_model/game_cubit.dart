import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/feature/team_vs_team/data/media_model.dart';
import 'package:game_app/feature/team_vs_team/data/media_repository.dart';

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

  GameLoaded({
    required this.movie,
    required this.series,
    required this.play,
    required this.currentTeamName,
    required this.team1Name,
    required this.team2Name,
    required this.isTeam1Turn,
  });
}

class GameError extends GameState {
  final String message;
  GameError(this.message);
}

class GameCubit extends Cubit<GameState> {
  final MediaRepository repository;
  String team1Name = '';
  String team2Name = '';
  bool isTeam1Turn = true;

  GameCubit(this.repository) : super(GameInitial());

  void initGame(String t1, String t2) async {
    emit(GameLoading());
    try {
      team1Name = t1.isEmpty ? 'الفريق الأول' : t1;
      team2Name = t2.isEmpty ? 'الفريق الثاني' : t2;
      isTeam1Turn = true;
      
      await repository.loadData();
      _generateNewRound();
    } catch (e) {
      emit(GameError(e.toString()));
    }
  }

  void nextTurn() {
    if (state is GameLoaded) {
      isTeam1Turn = !isTeam1Turn;
      _generateNewRound();
    }
  }

  void _generateNewRound() {
    emit(GameLoaded(
      movie: repository.getRandomMovie(),
      series: repository.getRandomSeries(),
      play: repository.getRandomPlay(),
      currentTeamName: isTeam1Turn ? team1Name : team2Name,
      team1Name: team1Name,
      team2Name: team2Name,
      isTeam1Turn: isTeam1Turn,
    ));
  }
}
