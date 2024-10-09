part of 'game_bloc.dart';

@immutable
sealed class GameEvent {}

final class LoadGame extends GameEvent{}
