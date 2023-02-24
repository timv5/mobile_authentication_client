import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_authnetication_client/screen/auth_screen.dart';
import 'package:mobile_authnetication_client/screen/crypto_market_screen.dart';
import 'package:mobile_authnetication_client/screen/news_screen.dart';
import 'package:mobile_authnetication_client/screen/splash_screen.dart';
import 'package:mobile_authnetication_client/screen/stock_notes_screen.dart';
import 'package:mobile_authnetication_client/screen/stocks_market_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile_authnetication_client/widget/logout_widget.dart';

import '../widget/side_menu_navigation_widget.dart';

class MainNavigationScreen extends StatefulWidget {

  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();

}

class _MainNavigationScreenState extends State<MainNavigationScreen> {

  final loggedInUser = FirebaseAuth.instance.currentUser;
  late final List<Widget> _pages = [CryptoMarketScreen(), StocksMarketScreen(), NewsScreen(), StockNotesScreen()];
  late final List<String> _pageNames = [
    AppLocalizations.of(context).cryptoMarket,
    AppLocalizations.of(context).stocksMarket,
    AppLocalizations.of(context).news,
    AppLocalizations.of(context).stockNotes,
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {_selectedPageIndex = index;});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          if (userSnapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(_pageNames[_selectedPageIndex]),
                actions: const <Widget>[LogoutWidget()],
              ),
              body: _pages[_selectedPageIndex],
              bottomNavigationBar: BottomNavigationBar(
                onTap: _selectPage,
                backgroundColor: Theme.of(context).colorScheme.background,
                unselectedItemColor: Theme.of(context).unselectedWidgetColor,
                selectedItemColor: Theme.of(context).secondaryHeaderColor,
                currentIndex: _selectedPageIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(icon: const Icon(Icons.currency_bitcoin), label: AppLocalizations.of(context).cryptoMarket),
                  BottomNavigationBarItem(icon: const Icon(Icons.money), label: AppLocalizations.of(context).stocksMarket),
                  BottomNavigationBarItem(icon: const Icon(Icons.newspaper), label: AppLocalizations.of(context).news),
                  BottomNavigationBarItem(icon: const Icon(Icons.note), label: AppLocalizations.of(context).stockNotes),
                ],
              ),
              drawer: SideMenuNavigationWidget(_selectPage),
            );
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
