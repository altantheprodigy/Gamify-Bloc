import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamifiy_bloc/model/search_response_game.dart';
import 'package:gamifiy_bloc/pages/HomePage/bloc/game_bloc.dart';
import 'package:gamifiy_bloc/pages/SearchPage/DataSource/remote_data_source.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final String query;
  final RemoteDataSearchSource remoteDataSearchSource;
  SearchBloc(this.query, {required this.remoteDataSearchSource}) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      emit(SearchLoading());
      try {
        final result = await remoteDataSearchSource.getSearchGames(query);
        emit(SearchLoaded(result));
      } catch (e) {
        emit(SearchEror(e.toString()));
      }
    });
  }
}
