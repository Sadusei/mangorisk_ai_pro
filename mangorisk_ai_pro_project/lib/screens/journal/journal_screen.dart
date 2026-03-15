import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../models/trade.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {

  final TextEditingController symbolController = TextEditingController();
  final TextEditingController pnlController = TextEditingController();
  final TextEditingController disciplineController = TextEditingController();

  String tradeType = "Long";
  String emotion = "Calm";

  void _addTrade(BuildContext ctx) {
    if (symbolController.text.isEmpty || pnlController.text.isEmpty) return;

    final trade = Trade(
      id: DateTime.now().toString(),
      symbol: symbolController.text,
      type: tradeType,
      instrument: symbolController.text,
      direction: tradeType,
      pnl: double.tryParse(pnlController.text) ?? 0.0,
      disciplineScore: int.tryParse(disciplineController.text) ?? 0,
      emotion: emotion,
      date: DateTime.now(),
    );

    Provider.of<AppProvider>(ctx, listen: false).addTrade(trade);

    symbolController.clear();
    pnlController.clear();
    disciplineController.clear();

    Navigator.pop(ctx);
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
              TextField(controller: symbolController, decoration: const InputDecoration(labelText: "Symbol", border: OutlineInputBorder())),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                initialValue: tradeType,
                items: const [DropdownMenuItem(value: "Long", child: Text("Long")), DropdownMenuItem(value: "Short", child: Text("Short"))],
                onChanged: (v) => setState(() => tradeType = v ?? "Long"),
                decoration: const InputDecoration(labelText: "Trade Type", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              TextField(controller: pnlController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Profit / Loss", border: OutlineInputBorder())),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                initialValue: emotion,
                items: const [
                  DropdownMenuItem(value: "Calm", child: Text("Calm")),
                  DropdownMenuItem(value: "FOMO", child: Text("FOMO")),
                  DropdownMenuItem(value: "Revenge", child: Text("Revenge")),
                  DropdownMenuItem(value: "Fear", child: Text("Fear")),
                ],
                onChanged: (v) => setState(() => emotion = v ?? "Calm"),
                decoration: const InputDecoration(labelText: "Emotion", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              TextField(controller: disciplineController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Discipline Score (0 - 100)", border: OutlineInputBorder())),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => _addTrade(ctx), child: const Text("Save Trade")),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Journal", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(onPressed: openAddTradeModal, icon: const Icon(Icons.add), label: const Text("Log Trade")),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Summary strip
          Row(
            children: [
              _statCard("Win Rate", "${provider.winRate.toStringAsFixed(1)}%", "+${(provider.winRate - 1).toStringAsFixed(1)}%"),
              const SizedBox(width: 12),
              _statCard("Avg Discipline", "${provider.avgDiscipline.toStringAsFixed(0)}/100", "+5%"),
              const SizedBox(width: 12),
              _statCard("Avg R:R", "1:2.4", "-0.2%"),
              const SizedBox(width: 12),
              _statCard("Total P&L", "\$${provider.totalPnL.toStringAsFixed(0)}", "+15%", highlight: true),
            ],
          ),

          const SizedBox(height: 16),

          // Filters
          Row(children: [
            _filterChip("All", selected: true),
            const SizedBox(width: 8),
            _filterChip("Wins"),
            const SizedBox(width: 8),
            _filterChip("Losses"),
            const SizedBox(width: 8),
            _filterChip("Flagged"),
          ]),

          const SizedBox(height: 16),

          // Table
          Container(
            decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE8E8E8)), borderRadius: BorderRadius.circular(8)),
            child: DataTable(
              columns: const [
                DataColumn(label: Text("Instrument")),
                DataColumn(label: Text("Direction")),
                DataColumn(label: Text("Outcome")),
                DataColumn(label: Text("Discipline")),
                DataColumn(label: Text("P&L")),
                DataColumn(label: Text("Date")),
              ],
              rows: provider.trades.map((t) {
                final outcome = t.pnl > 0 ? 'Win' : (t.pnl < 0 ? 'Loss' : 'BE');
                return DataRow(cells: [
                  DataCell(Row(children: [CircleAvatar(radius: 12, child: Text(t.symbol.isNotEmpty ? t.symbol[0] : '?')), const SizedBox(width: 8), Text(t.symbol)])),
                  DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: t.type == 'Long' ? Colors.green.shade50 : Colors.grey.shade100, borderRadius: BorderRadius.circular(12)), child: Text(t.type))),
                  DataCell(Row(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: t.pnl > 0 ? Colors.green : (t.pnl < 0 ? Colors.red : Colors.grey), shape: BoxShape.circle)), const SizedBox(width: 8), Text(outcome)])),
                  DataCell(Row(children: [Expanded(child: LinearProgressIndicator(value: (t.disciplineScore.clamp(0,100))/100, backgroundColor: Colors.grey.shade200, color: Colors.orange)), const SizedBox(width: 8), Text(t.disciplineScore.toString())])),
                  DataCell(Text(t.pnl >= 0 ? '\$${t.pnl.toStringAsFixed(2)}' : '\$${t.pnl.toStringAsFixed(2)}', style: TextStyle(color: t.pnl >= 0 ? Colors.green : Colors.red, fontWeight: FontWeight.bold))),
                  DataCell(Text('${t.date.month}/${t.date.day}/${t.date.year}', style: const TextStyle(fontSize: 12, color: Colors.grey))),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String main, String change, {bool highlight = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE8E8E8)), borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Row(children: [Text(main, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: highlight ? Colors.green : Colors.black)), const SizedBox(width: 8), Text(change, style: const TextStyle(fontSize: 12, color: Colors.green))]),
        ]),
      ),
    );
  }

  Widget _filterChip(String label, {bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: selected ? Colors.orange : Colors.grey.shade100, borderRadius: BorderRadius.circular(999)),
      child: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.black54, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}