import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final Function(int) onItemSelected;
  final VoidCallback? onNewEntry;
  final int selectedIndex;

  const Sidebar({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
    this.onNewEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Color(0xFFE8E8E8))),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),

          /// LOGO
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.analytics, color: Colors.orange),
              SizedBox(width: 8),
              Text(
                "MangoRisk AI",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          ),

          const SizedBox(height: 40),

          _navItem(Icons.dashboard, "Dashboard", 0),
          _navItem(Icons.book, "Journal", 1),
          _navItem(Icons.insights, "Strategy", 2),
          _navItem(Icons.monitor, "Analytics", 3),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 45),
              ),
              icon: const Icon(Icons.add),
              label: const Text("New Entry"),
              onPressed: onNewEntry,
            ),
          )
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String title, int index) {
    final selected = selectedIndex == index;

    return ListTile(
      leading: Icon(icon,
          color: selected ? Colors.orange : Colors.grey),
      title: Text(
        title,
        style: TextStyle(
            color: selected ? Colors.orange : Colors.black87,
            fontWeight: FontWeight.w500),
      ),
      selected: selected,
      onTap: () => onItemSelected(index),
    );
  }
}
