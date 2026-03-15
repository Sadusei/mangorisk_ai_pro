class DisciplineScorer {

  static int calculate({

    required double rulesFollowedPercent,
    required String slMove,
    required String emotion,
    required int starRating,

  }) {

    double ruleScore = rulesFollowedPercent * 35;

    double slScore = 0;

    if(slMove == "held") slScore = 30;
    if(slMove == "tighter") slScore = 16.5;
    if(slMove == "wider") slScore = 0;

    double emotionScore = 0;

    if(emotion == "Calm") emotionScore = 20;
    if(emotion == "FOMO") emotionScore = 2;
    if(emotion == "Revenge") emotionScore = 0;

    double ratingScore = (starRating / 5) * 15;

    return (ruleScore + slScore + emotionScore + ratingScore).round();
  }
}
