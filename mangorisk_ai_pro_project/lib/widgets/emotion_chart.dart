import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class EmotionChart extends StatelessWidget {

  final Map<String,int> data;

  const EmotionChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 220,

      child: BarChart(

        BarChartData(

          borderData: FlBorderData(show: false),

          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {

                  final emotions = data.keys.toList();

                  return Text(
                    emotions[value.toInt()],
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),

          barGroups: data.entries.map((e){

            int index = data.keys.toList().indexOf(e.key);

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: e.value.toDouble(),
                  width: 18,
                )
              ],
            );

          }).toList(),
        ),
      ),
    );
  }
}
