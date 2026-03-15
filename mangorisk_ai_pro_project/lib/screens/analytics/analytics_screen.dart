import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text('AI Behavioral Analytics', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Real-time discipline and psychological tracking', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            // Top score
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE8E8E8)), borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Average Discipline Score', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(children: [Text(provider.avgDiscipline.toStringAsFixed(0), style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)), const SizedBox(width: 8), const Text('/100', style: TextStyle(color: Colors.grey))]),
                  ]),
                  Row(children: List.generate(4, (i) => Container(margin: const EdgeInsets.only(left: 6), width: 8, height: 64, decoration: BoxDecoration(color: const Color.fromRGBO(255,165,0,0.2), borderRadius: BorderRadius.circular(4)), child: Align(alignment: Alignment.bottomCenter, child: Container(height: (i+1) * 12.0, color: Colors.orange)))))
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Key stats
            Row(children: [
              _statBox('Win Rate', '${provider.winRate.toStringAsFixed(1)}%'),
              const SizedBox(width: 12),
              _statBox('Avg R:R', '1:2.4'),
              const SizedBox(width: 12),
              _statBox('Total P&L', '\$${provider.totalPnL.toStringAsFixed(2)}'),
              const SizedBox(width: 12),
              _statBox('Total Trades', '${provider.totalTrades}'),
            ]),

            const SizedBox(height: 20),

            // Behavioral Flags
            const Text('Behavioral Flags', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: provider.behaviourFlags.map((f) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE8E8E8)),
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromRGBO(255, 0, 0, 0.05),
                  ),
                  width: 240,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(f, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      const Text('Flag description', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Emotion vs Win Rate
            const Text('Emotion vs Win Rate', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE8E8E8)), borderRadius: BorderRadius.circular(8), color: Colors.white), child: Column(children: [
              _emotionRow('Calm', '78%', 0.78, Colors.green),
              const SizedBox(height: 8),
              _emotionRow('Anxious', '42%', 0.42, Colors.orange),
              const SizedBox(height: 8),
              _emotionRow('Greedy', '24%', 0.24, Colors.red),
            ])),

            const SizedBox(height: 20),

            // AI Insights
            const Text('AI Behavioral Insights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Column(children: [
              _insightCard('Mid-Day Slump', 'Your win rate drops by 35% between 1:00 PM and 3:00 PM EST. Consider reducing position sizes during this window.'),
              const SizedBox(height: 8),
              _insightCard('Patience Payoff', 'Trades held for at least 45 minutes have a 2.1x higher Profit Factor compared to scalps.'),
            ])
          ],
        ),
      ),
    );
  }

  Widget _statBox(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE8E8E8)), borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w700)), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]),
      ),
    );
  }

  Widget _emotionRow(String label, String pctText, double pct, Color color) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label), Text(pctText)]),
      const SizedBox(height: 6),
      ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: pct, minHeight: 10, backgroundColor: Colors.grey.shade200, color: color)),
    ]);
  }

  Widget _insightCard(String title, String body) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE8E8E8)), borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 6), Text(body, style: const TextStyle(color: Colors.grey))]),
    );
  }
}
