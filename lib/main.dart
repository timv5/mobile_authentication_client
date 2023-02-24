import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_authnetication_client/l10n/l10n.dart' as SupportedLanguages;
import 'package:mobile_authnetication_client/screen/auth_screen.dart';
import 'package:mobile_authnetication_client/screen/crypto_market_screen.dart';
import 'package:mobile_authnetication_client/screen/main_navigation_screen.dart';
import 'package:mobile_authnetication_client/screen/news_screen.dart';
import 'package:mobile_authnetication_client/screen/splash_screen.dart';
import 'package:mobile_authnetication_client/screen/stock_notes_screen.dart';
import 'package:mobile_authnetication_client/screen/stocks_market_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: SupportedLanguages.L10n.all,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
          backgroundColor: Colors.pink,
          errorColor: Colors.lightBlue,
        ),
        dividerColor: Colors.black,
        unselectedWidgetColor: Colors.white,
        secondaryHeaderColor: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.orange,
          )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.orange,
            side: const BorderSide(color: Colors.orange)
          )
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          if (userSnapshot.hasData) {
            return const MainNavigationScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
      routes: {
        AuthScreen.routeName: (context) => const AuthScreen(),
        CryptoMarketScreen.routeName: (context) => const CryptoMarketScreen(),
        StocksMarketScreen.routeName: (context) => const StocksMarketScreen(),
        NewsScreen.routeName: (context) => const NewsScreen(),
        StockNotesScreen.routeName: (context) => const StockNotesScreen(),
      },
    );
  }
}
