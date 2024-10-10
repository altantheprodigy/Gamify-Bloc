import 'package:dio/dio.dart';
import 'package:gamifiy_bloc/model/search_response_game.dart';

class RemoteDataSearchSource {
  final dio = Dio(BaseOptions(baseUrl: "https://api.rawg.io/api"));

  getSearchGames(String query) async {
    final response = await dio.get(
      "/games",
      queryParameters: {
        "search" : query,
        "key" : "48d237decca24ad3a5a4d253dbaf6473",
      }
    );
    print(response.statusCode);
    final result = SearchGameResponseModel.fromJson(response.data);
    print(result);
    return SearchGameResponseModel.fromJson(response.data);
  }
}