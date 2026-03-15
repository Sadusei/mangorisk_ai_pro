import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../widgets/text_field.dart';
import '../../widgets/primary_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  bool login = true;

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Container(
          width: 360,
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              const Text(
                "MangoRisk AI",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height:30),

              if(!login)
                AppTextField(
                  label: "Username",
                  controller: username,
                ),

              const SizedBox(height:12),

              AppTextField(
                label: "Email",
                controller: email,
              ),

              const SizedBox(height:12),

              AppTextField(
                label: "Password",
                controller: password,
                obscure: true,
              ),

              if(login)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {

                        final messenger = ScaffoldMessenger.of(context);

                        await Supabase.instance.client.auth
                            .resetPasswordForEmail(email.text);

                        if (!mounted) return;

                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text("Reset email sent"),
                          ),
                        );
                      },
                    child: const Text("Forgot Password?"),
                  ),
                ),

              const SizedBox(height:16),

              PrimaryButton(
                text: login ? "Login" : "Create Account",
                onPressed: (){
                  context.go("/app");
                },
              ),

              const SizedBox(height:10),

              TextButton(
                onPressed: (){
                  setState(() {
                    login = !login;
                  });
                },
                child: Text(
                  login
                      ? "Create account"
                      : "Already have an account?",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}