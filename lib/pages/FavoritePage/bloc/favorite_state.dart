part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteLoaded extends FavoriteState {
  final List<Favorite> favorites;
  FavoriteLoaded(this.favorites);
}

final class FavoriteError extends FavoriteState {
  final String eror;
  FavoriteError(this.eror);
}
