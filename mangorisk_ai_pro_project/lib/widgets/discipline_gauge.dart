import 'package:flutter/material.dart';

class DisciplineGauge extends StatelessWidget {
  final double score;

  const DisciplineGauge({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE8E8E8)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            "DISCIPLINE SCORE",
            style: TextStyle(
                fontSize: 12,
                letterSpacing: 1,
                color: Colors.grey,
                fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 10,
                  color: Colors.orange,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
              Column(
                children: [
                  Text(
                    score.toInt().toString(),
                    style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text("out of 100")
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
