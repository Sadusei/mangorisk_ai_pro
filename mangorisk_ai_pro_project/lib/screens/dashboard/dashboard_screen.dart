import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../widgets/sidebar.dart';
import '../../screens/journal/journal_screen.dart';
import '../../screens/strategy/strategy_screen.dart';
import '../../screens/analytics/analytics_screen.dart';
import '../../models/trade.dart';
import '../../widgets/performance_card.dart';
import '../../widgets/discipline_gauge.dart';
import '../../widgets/equity_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int selectedIndex = 0;
  // controllers for New Entry modal
  final TextEditingController _symbolController = TextEditingController();
  final TextEditingController _pnlController = TextEditingController();
  final TextEditingController _disciplineController = TextEditingController();

  String _tradeType = "Long";
  String _emotion = "Calm";

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: Row(
        children: [

          /// SIDEBAR
          Sidebar(
            selectedIndex: selectedIndex,
            onItemSelected: (i){
              setState(() => selectedIndex = i);
            },
            onNewEntry: (){
              setState(() => selectedIndex = 1);
              openAddTradeModal();
            },
          ),

          /// MAIN CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: _buildContent(provider),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(AppProvider provider) {
    switch (selectedIndex) {
      case 1:
        return const JournalScreen();
      case 2:
        return const StrategyScreen();
      case 3:
        return const AnalyticsScreen();
      case 0:
      default:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Discipline Workspace",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar()
                ],
              ),

              const SizedBox(height: 30),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: DisciplineGauge(
                      score: provider.avgDiscipline,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: PerformanceCard(
                                title: "Win Rate",
                                value: "${provider.winRate.toStringAsFixed(1)}%",
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: PerformanceCard(
                                title: "Total PnL",
                                value: "\$${provider.totalPnL.toStringAsFixed(0)}",
                                color: provider.totalPnL >= 0 ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const EquityChart(),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
              const Text(
                "Behavioural Flags",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: provider.behaviourFlags
                    .map((flag) => Chip(label: Text(flag), backgroundColor: Colors.orange.shade100))
                    .toList(),
              ),

              const SizedBox(height: 40),
              const Text(
                "Recent Trades",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE8E8E8)), borderRadius: BorderRadius.circular(12)),
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Symbol")),
                    DataColumn(label: Text("Type")),
                    DataColumn(label: Text("P&L")),
                    DataColumn(label: Text("Score")),
                  ],
                  rows: provider.trades.map((trade) {
                    return DataRow(cells: [
                      DataCell(Text(trade.symbol)),
                      DataCell(Text(trade.type)),
                      DataCell(Text("\$${trade.pnl.toStringAsFixed(2)}", style: TextStyle(color: trade.pnl >= 0 ? Colors.green : Colors.red))),
                      const DataCell(Text("N/A")),
                    ]);
                  }).toList(),
                ),
              )
            ],
          ),
        );
    }
  }

  void openAddTradeModal(){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("New Trade Entry", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                controller: _symbolController,
                decoration: const InputDecoration(labelText: "Symbol", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                initialValue: _tradeType,
                items: const [DropdownMenuItem(value: "Long", child: Text("Long")), DropdownMenuItem(value: "Short", child: Text("Short"))],
                onChanged: (value){ setState(() { _tradeType = value!; }); },
                decoration: const InputDecoration(labelText: "Trade Type", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _pnlController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Profit / Loss", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                initialValue: _emotion,
                items: const [
                  DropdownMenuItem(value: "Calm", child: Text("Calm")),
                  DropdownMenuItem(value: "FOMO", child: Text("FOMO")),
                  DropdownMenuItem(value: "Revenge", child: Text("Revenge")),
                  DropdownMenuItem(value: "Fear", child: Text("Fear")),
                ],
                onChanged: (value){ setState(() { _emotion = value!; }); },
                decoration: const InputDecoration(labelText: "Emotion", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _disciplineController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Discipline Score (0 - 100)", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                  child: ElevatedButton(
                  onPressed: (){
                    if(_symbolController.text.isEmpty || _pnlController.text.isEmpty) return;
                    final trade = Trade(
                      id: DateTime.now().toString(),
                      symbol: _symbolController.text,
                      type: _tradeType,
                      instrument: _symbolController.text,
                      direction: _tradeType,
                      pnl: double.tryParse(_pnlController.text) ?? 0.0,
                      disciplineScore: int.tryParse(_disciplineController.text) ?? 0,
                      emotion: _emotion,
                      date: DateTime.now(),
                    );
                    Provider.of<AppProvider>(ctx, listen: false).addTrade(trade);
                    _symbolController.clear(); _pnlController.clear(); _disciplineController.clear();
                    Navigator.pop(ctx);
                  },
                  child: const Text("Save Trade"),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
