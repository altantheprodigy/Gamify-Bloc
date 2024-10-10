part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class LoadSearchGame extends SearchEvent{}
