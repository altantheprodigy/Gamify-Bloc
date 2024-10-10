part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final SearchGameResponseModel searchGames;
  SearchLoaded(this.searchGames);
}

final class SearchEror extends SearchState {
  final String message;
  SearchEror(this.message);
}
