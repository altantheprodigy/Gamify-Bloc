import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamifiy_bloc/pages/HomePage/DataSource/remote_game_source.dart';
import 'package:gamifiy_bloc/pages/HomePage/bloc/game_bloc.dart';

class Provider {
  static providers() {
    return [
    BlocProvider(
      create: (_) => GameBloc(remoteDataSource: RemoteDataSource()),
    )];}}