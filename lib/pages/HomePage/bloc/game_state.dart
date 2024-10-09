part of 'game_bloc.dart';

@immutable
sealed class GameState {}

final class GameInitial extends GameState {}

final class GameLoading extends GameState {}

final class GameLoaded extends GameState {
  final GameResponseModel games;
  GameLoaded(this.games);
}

final class GameEror extends GameState {
  final String message;
  GameEror(this.message);
}
