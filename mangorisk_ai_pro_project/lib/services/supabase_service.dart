import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {

  final supabase = Supabase.instance.client;

  Future signUp(
      String email,
      String password,
      ) async {

    await supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future signIn(
      String email,
      String password,
      ) async {

    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future signOut() async {

    await supabase.auth.signOut();

  }

}
