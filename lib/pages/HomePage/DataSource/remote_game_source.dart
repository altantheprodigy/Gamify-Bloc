import 'package:dio/dio.dart';
import 'package:gamifiy_bloc/model/all_game_response.dart';
import 'package:gamifiy_bloc/model/all_response_game.dart';

class RemoteDataSource {
  final dio = Dio(BaseOptions(baseUrl: "https://api.rawg.io/api"));

  getGames() async {
    final response = await dio.get(
      "/games",
      queryParameters: {
        "key": "48d237decca24ad3a5a4d253dbaf6473",
        "page": 2,
        "page_size": 10
      },
    );
    // print("${response.statusCode}");
    // final gameResponse = gameResponseModelFromJson(response.data);
    // print(gameResponse.results);
    return GameResponseModel.fromJson(response.data);
  }
}
