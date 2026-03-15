import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  bool login = true;
  bool hidePassword = true;

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(
        child: SingleChildScrollView(

          child: Container(

            width: 420,
            padding: const EdgeInsets.symmetric(horizontal: 24),

            child: Column(
              children: [

                const SizedBox(height: 40),

                /// LOGO
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5A623),
                    shape: BoxShape.rectangle,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  "MangoRisk AI",
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111111),
                  ),
                ),

                const SizedBox(height: 40),

                /// LOGIN / SIGNUP TAB
                Row(
                  children: [

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            login = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: login
                                    ? const Color(0xFFF5A623)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Log in",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: login ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            login = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: !login
                                    ? const Color(0xFFF5A623)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Sign up",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: !login ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// USERNAME (Signup only)
                if (!login)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Username",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 6),

                      TextField(
                        controller: username,
                        decoration: InputDecoration(
                          hintText: "Enter your username",
                          filled: true,
                          fillColor: const Color(0xFFFAFAFA),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFE8E8E8),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),

                /// EMAIL
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Email",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 6),

                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        filled: true,
                        fillColor: const Color(0xFFFAFAFA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFE8E8E8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// PASSWORD
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Password",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        if (login)
                          GestureDetector(
                            onTap: () async {

                              final messenger =
                                  ScaffoldMessenger.of(context);

                              await Supabase.instance.client.auth
                                  .resetPasswordForEmail(email.text);

                              if (!mounted) return;

                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text("Reset email sent"),
                                ),
                              );
                            },
                            child: Text(
                              "Forgot password?",
                              style: GoogleFonts.inter(
                                color: const Color(0xFFF5A623),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    TextField(
                      controller: password,
                      obscureText: hidePassword,

                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        filled: true,
                        fillColor: const Color(0xFFFAFAFA),

                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFE8E8E8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// CONTINUE BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    onPressed: () {

                      /// After successful login/signup
                      context.go("/app");
                    },

                    child: Text(
                      login ? "Continue" : "Create Account",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// DIVIDER
                Row(
                  children: [

                    const Expanded(
                      child: Divider(color: Color(0xFFE8E8E8)),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "OR CONTINUE WITH",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Divider(color: Color(0xFFE8E8E8)),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// SOCIAL LOGIN BUTTONS
                Row(
                  children: [

                    Expanded(
                      child: socialButton("Google", Icons.g_mobiledata),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: socialButton("GitHub", Icons.code),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                /// TERMS
                Text(
                  "By continuing, you agree to MangoRisk AI's\nTerms of Service and Privacy Policy.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialButton(String text, IconData icon) {

    return Container(
      height: 52,

      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE8E8E8)),
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(icon, size: 20),

          const SizedBox(width: 6),

          Text(
            text,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
