import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/router.dart';
import 'providers/app_provider.dart';
import 'theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "SUPABASE_URL",
    anonKey: "SUPABASE_ANON_KEY",
  );

  runApp(const MangoRiskApp());
}

class MangoRiskApp extends StatelessWidget {
  const MangoRiskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "MangoRisk AI",
        theme: AppTheme.lightTheme,
        routerConfig: router,
      ),
    );
  }
}