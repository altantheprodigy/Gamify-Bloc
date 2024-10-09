part of 'detail_bloc.dart';

@immutable
sealed class DetailState {}

final class DetailInitial extends DetailState {}

final class DetailLoading extends DetailState {}

final class DetailLoaded extends DetailState {
  final DetailGameResponseModel detailGames;
  DetailLoaded(this.detailGames);
}

final class DetailEror extends DetailState {
  final String message;
  DetailEror(this.message);
}
