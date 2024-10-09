class DataGame {
  final List<Game> result;
  DataGame({required this.result});
  factory DataGame.fromJson(Map<String, dynamic> json) =>DataGame(
      result: List.from(json["results"].map((game) => Game.fromModel(game)))
  );
}


class Game {
  int id;
  String name;
  double rating;
  String image;
  DateTime released;

  Game({
    required this.id,
    required this.name,
    required this.rating,
    required this.released,
    required this.image,
  });
  factory Game.fromModel(Map<String, dynamic> json) => Game(
    id: json["id"],
    name: json["name"],
    image: json["background_image"],
    rating: json["rating"]?.toDouble(),
    released: DateTime.parse(json["released"]),
  );
}
