import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Account"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text("Email: user@email.com"),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: (){
                context.go("/auth");
              },
              child: const Text("Sign Out"),
            )
          ],
        ),
      ),
    );
  }
}