import 'package:dio/dio.dart';
import 'package:gamifiy_bloc/model/detail_game_response.dart';

class RemoteDetailDataSource {
  final dio = Dio(BaseOptions(baseUrl: "https://api.rawg.io/api"));

  getDetailGames(int gameId) async {
    final response = await dio.get(
      "/games/$gameId",
      queryParameters: {
        "key": "48d237decca24ad3a5a4d253dbaf6473"
      }
    );
    print("response status code detail : ${response.statusCode}");
    return DetailGameResponseModel.fromJson(response.data);
  }
}