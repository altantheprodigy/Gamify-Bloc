import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamifiy_bloc/model/db_helper.dart';
import 'package:gamifiy_bloc/model/favorites_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'package:dio/dio.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final Database db = DbHelper.getDb();

  FavoriteBloc() : super(FavoriteInitial()) {
    on<LoadFavorites>((event, emit) async {
      emit(FavoriteLoading());
      try {
        final List<Map<String, dynamic>> mapFavorites = await db.query("Game");
        final favorites =
            mapFavorites.map((e) => Favorite.fromMap(map: e)).toList();
        emit(FavoriteLoaded(favorites));
      } catch (e) {
        emit(FavoriteError(e.toString()));
      }
    });

    on<AddFavorites>((event, emit) async {
      try {
        final currentState = state;
        if (currentState is FavoriteLoaded) {
          final response = await get(Uri.parse(event.favorite.image));
          final documentDirectory = await getApplicationDocumentsDirectory();
          final firstPath = "${documentDirectory.path}/images";
          final filePathAndName = "$firstPath/${event.favorite.id}.png";
          await Directory(firstPath).create(recursive: true);
          File file = File(filePathAndName);

          if (!await file.exists()) {
            file.writeAsBytesSync(response.bodyBytes);
            Favorite favorite = Favorite(
              id: event.favorite.id,
              title: event.favorite.title,
              image: filePathAndName,
              rating: event.favorite.rating,
              released: event.favorite.released,
            );
            await db.insert("Game", favorite.toMap());
            final updatedFavorites = List<Favorite>.from(currentState.favorites)
              ..add(favorite);
            emit(FavoriteLoaded(updatedFavorites));
          }
        }
      } catch (e) {
        emit(FavoriteError(e.toString()));
      }
    });

    on<RemoveFavorite>((event, emit) async {
      try {
        final currentState = state;
        if (currentState is FavoriteLoaded) {
          await db.delete(
            "Game",
            where: 'id = ?',
            whereArgs: [event.favorite.id],
          );
          final documentDirectory = await getApplicationDocumentsDirectory();
          final filePathAndName =
              '${documentDirectory.path}/images/${event.favorite.id}.png';
          File file = File(filePathAndName);

          if (await file.exists()) {
            await file.delete();
          }

          final updatedFavorites = currentState.favorites
              .where((fav) => fav.id != event.favorite.id)
              .toList();
          emit(FavoriteLoaded(updatedFavorites));
        }
      } catch (e) {
        emit(FavoriteError(e.toString()));
      }
    });
  }
}
