import 'package:flutter/material.dart';

import '../dashboard/dashboard_screen.dart';
import '../journal/journal_screen.dart';
import '../strategy/strategy_screen.dart';
import '../analytics/analytics_screen.dart';
import '../settings/settings_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {

  int index = 0;

  final pages = const [

    DashboardScreen(),
    JournalScreen(),
    StrategyScreen(),
    AnalyticsScreen(),
    SettingsScreen(),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[index],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: index,

        onTap: (i){
          setState(() {
            index = i;
          });
        },

        items: const [

          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Journal"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.psychology),
              label: "Strategy"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: "Analytics"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account"
          ),
        ],
      ),
    );
  }
}