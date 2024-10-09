import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamifiy_bloc/model/detail_game_response.dart';
import 'package:gamifiy_bloc/pages/DetailPage/DataSource/remote_detail_game.dart';
import 'package:gamifiy_bloc/pages/HomePage/bloc/game_bloc.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final int gameId;
  final RemoteDetailDataSource remoteDetailDataSource;
  DetailBloc({required this.remoteDetailDataSource,required this.gameId}) : super(DetailInitial()) {
    on<DetailEvent>((event, emit) async{
      emit(DetailLoading());
      try {
        final result = await remoteDetailDataSource.getDetailGames(gameId);
        emit(DetailLoaded(result));
      } catch (e) {
        emit(DetailEror(e.toString()));
      }
    });
  }
}
