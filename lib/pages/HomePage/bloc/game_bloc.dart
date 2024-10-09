import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamifiy_bloc/model/all_game_response.dart';
import 'package:gamifiy_bloc/model/all_response_game.dart';
import 'package:gamifiy_bloc/pages/HomePage/DataSource/remote_game_source.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final RemoteDataSource remoteDataSource;
  GameBloc({required this.remoteDataSource}) : super(GameInitial()) {
    on<LoadGame>((event, emit) async {
      emit(GameLoading());
      try {
        final result = await remoteDataSource.getGames();
        emit(GameLoaded(result));
      } catch (e) {
        emit(GameEror(state.toString()));
      }
    });
  }
}
