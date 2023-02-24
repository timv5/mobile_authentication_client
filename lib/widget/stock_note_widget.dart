import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_authnetication_client/providers/stock_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StockNoteWidget extends StatelessWidget {
  final String id;
  final String title;
  final String body;
  final String createDate;
  final String stockSymbol;

  const StockNoteWidget(
      this.id, this.title, this.body, this.createDate, this.stockSymbol,
      {super.key});

  @override
  Widget build(BuildContext context) {
    void _deleteStockNote() async {
      Provider.of<StockProvider>(context, listen: false)
          .deleteStockNote(stockSymbol);
    }

    return Dismissible(
        key: ValueKey(id),
        onDismissed: (direction) {
          _deleteStockNote();
        },
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(AppLocalizations.of(context).stockNotesDeleteAlertTitle),
                content: Text(AppLocalizations.of(context).stockNotesDeleteAlertBody),
                backgroundColor: Theme.of(context).colorScheme.background,
                actions: [
                  TextButton(onPressed: () {Navigator.of(context).pop(false);}, child: Text(AppLocalizations.of(context).no)),
                  TextButton(onPressed: () {Navigator.of(context).pop(true);}, child: Text(AppLocalizations.of(context).yes)),
                ],
              )
          );
        },
        direction: DismissDirection.endToStart,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: Text(stockSymbol),
              title: Text(title),
              subtitle: Text(body),
            ),
          ),
        ));
  }
}
