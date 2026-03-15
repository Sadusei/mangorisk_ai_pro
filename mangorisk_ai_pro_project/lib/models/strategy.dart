class Strategy {

  final String id;
  final String name;
  final int score;

  Strategy({
    required this.id,
    required this.name,
    required this.score,
  });

  factory Strategy.fromJson(Map<String,dynamic> json){
    return Strategy(
      id: json['id'],
      name: json['name'],
      score: json['score'],
    );
  }

}