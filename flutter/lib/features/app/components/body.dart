import 'package:flutter/material.dart';
import 'package:ai_dreamer/features/app/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hackathon - AI Dreamers Teams',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouterFactory.createRouter(context),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        textTheme: GoogleFonts.barlowTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
