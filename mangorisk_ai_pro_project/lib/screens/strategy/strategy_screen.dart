import 'package:flutter/material.dart';

class StrategyScreen extends StatelessWidget {
  const StrategyScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Strategy Vault"),
      ),

      body: ListView(

        children: const [

          ListTile(
            title: Text("Breakout Strategy"),
            trailing: CircleAvatar(
              child: Text("82"),
            ),
          ),

          ListTile(
            title: Text("Pullback Strategy"),
            trailing: CircleAvatar(
              child: Text("74"),
            ),
          ),

        ],
      ),
    );
  }
}