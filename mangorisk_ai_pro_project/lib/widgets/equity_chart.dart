import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class EquityChart extends StatelessWidget {
  const EquityChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE8E8E8)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Equity Curve",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: const FlTitlesData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: Colors.orange,
                    spots: const [
                      FlSpot(0, 2),
                      FlSpot(1, 2.5),
                      FlSpot(2, 3),
                      FlSpot(3, 4),
                      FlSpot(4, 3.8),
                      FlSpot(5, 5),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
