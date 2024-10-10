part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

class LoadFavorites extends FavoriteEvent{}

class AddFavorites extends FavoriteEvent {
  final Favorite favorite;
  AddFavorites(this.favorite);
}

class RemoveFavorite extends FavoriteEvent {
  final Favorite favorite;
  RemoveFavorite(this.favorite);
}
