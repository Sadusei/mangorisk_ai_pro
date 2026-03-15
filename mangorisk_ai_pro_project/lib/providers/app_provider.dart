import 'package:flutter/material.dart';
import '../models/trade.dart';

class AppProvider extends ChangeNotifier {

  // -------------------------------
  // STATE
  // -------------------------------

  final List<Trade> _trades = [];

  List<Trade> get trades => _trades;

  // -------------------------------
  // BASIC STATS
  // -------------------------------

  int get totalTrades => _trades.length;

  double get totalPnL {

    double total = 0;

    for (var t in _trades) {
      total += t.pnl;
    }

    return total;
  }

  double get winRate {

    if (_trades.isEmpty) return 0;

    int wins = _trades.where((t) => t.pnl > 0).length;

    return (wins / _trades.length) * 100;
  }

  // -------------------------------
  // DISCIPLINE SCORE
  // -------------------------------

  double get avgDiscipline {

    if (_trades.isEmpty) return 0;

    double total = 0;

    for (var t in _trades) {
      total += t.disciplineScore;
    }

    return total / _trades.length;
  }

  // -------------------------------
  // BEHAVIORAL FLAGS
  // -------------------------------

  List<String> get behaviourFlags {

    List<String> flags = [];

    for (var t in _trades) {

      if (t.emotion == "FOMO") {
        flags.add("FOMO");
      }

      if (t.emotion == "Revenge") {
        flags.add("REVENGE");
      }

      if (t.disciplineScore < 50) {
        flags.add("RULES BROKEN");
      }
    }

    return flags.toSet().toList();
  }

  // -------------------------------
  // EMOTION ANALYTICS
  // -------------------------------

  Map<String, int> get emotionStats {

    Map<String, int> stats = {
      "Calm": 0,
      "FOMO": 0,
      "Revenge": 0,
    };

    for (var t in _trades) {

      if (stats.containsKey(t.emotion)) {
        stats[t.emotion] = stats[t.emotion]! + 1;
      }
    }

    return stats;
  }

  // -------------------------------
  // CRUD OPERATIONS
  // -------------------------------

  void addTrade(Trade trade) {

    _trades.add(trade);

    notifyListeners();
  }

  void deleteTrade(String id) {

    _trades.removeWhere((t) => t.id == id);

    notifyListeners();
  }

  void clearTrades() {

    _trades.clear();

    notifyListeners();
  }
}