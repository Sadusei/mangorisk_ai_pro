class Trade {

  final String id;
  final String symbol;
  final String type;
  final String instrument;
  final String direction;
  final double pnl;
  final int disciplineScore;
  final String emotion;
  final DateTime date;

  Trade({
    required this.id,
    required this.symbol,
    required this.type,
    required this.instrument,
    required this.direction,
    required this.pnl,
    required this.disciplineScore,
    required this.emotion,
    required this.date,
  });

  factory Trade.fromJson(Map<String,dynamic> json){
    return Trade(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      type: json['type'] ?? '',
      instrument: json['instrument'] ?? '',
      direction: json['direction'] ?? '',
      pnl: (json['pnl'] is num) ? (json['pnl'] as num).toDouble() : double.tryParse(json['pnl']?.toString() ?? '') ?? 0.0,
      disciplineScore: (json['discipline_score'] is int)
          ? json['discipline_score'] as int
          : int.tryParse(json['discipline_score']?.toString() ?? '') ?? 0,
      emotion: json['emotion'] ?? '',
      date: DateTime.parse(json['date'].toString()),
    );
  }

}