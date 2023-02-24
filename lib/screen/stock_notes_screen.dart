import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_authnetication_client/providers/stock_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widget/stock_note_widget.dart';

class StockNotesScreen extends StatelessWidget {

  static const routeName = '/stockNotes';

  const StockNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<StockProvider>(
        create: (context){
          return StockProvider();
        },
      ),],
      child: Builder(builder: (BuildContext context){
        BuildContext rootContext = context;
        return FutureBuilder(
          future: Provider.of<StockProvider>(rootContext, listen: false).fetchAll(),
          builder: (context,  snapshot) => snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator(),)
              : Center(
            child: Consumer<StockProvider>(
              child: Center(child: Text(AppLocalizations.of(context).noData),),
              builder: (ctx, data, ch) => data.stockNotes.isEmpty
                  ? ch!
                  : ListView.builder(
                  itemCount: data.stockNotes.length,
                  itemBuilder: (ctx, index) => StockNoteWidget(
                    data.stockNotes[index].id,
                    data.stockNotes[index].title,
                    data.stockNotes[index].body,
                    data.stockNotes[index].createDate,
                    data.stockNotes[index].stockSymbol,
                  )
              ),
            ),
          ),
        );
      }),
    );
  }
}
