import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_authnetication_client/localDB/dao.dart';

import '../localDB/model/stock_note.dart';

class StockProvider with ChangeNotifier {

  List<StockNote> _stockNotes = [];

  List<StockNote> get stockNotes {
    return [..._stockNotes];
  }

  void deleteStockNote(String stockSymbol) {
    _stockNotes.removeWhere((element) => element.stockSymbol == stockSymbol);
    notifyListeners();

    // delete from local db
    Dao.delete('stock_notes', stockSymbol);
  }

  void addStockNote(String title, String body, String stockSymbol) {
    final DateTime dateTime = DateTime.now();
    final newStockNote = StockNote(DateTime.now().toString(), title, body, dateTime.toString(), stockSymbol);
    _stockNotes.add(newStockNote);
    notifyListeners();

    // insert to local db
    Dao.insert('stock_notes', {
      'id': newStockNote.id,
      'title': newStockNote.title,
      'body': newStockNote.body,
      'create_date': newStockNote.createDate,
      'stock_symbol': newStockNote.stockSymbol
    });
  }

  Future<void> fetchAll() async {
    final data = await Dao.fetchAll('stock_notes');
    _stockNotes = data.map((e) => StockNote(
        e['id'].toString(),
        e['title'].toString(),
        e['body'].toString(),
        e['create_date'].toString(),
        e['stock_symbol'].toString()
    )).toList();
    notifyListeners();
  }

// Future<void> fetchBySymbol(String stockSymbol) async {
//   final data = await Dao.fetchBySymbol(db_table_name, stockSymbol);
//   List<StockNote> tmpStockNotes = data.map((e) => StockNote(
//       e['id'].toString(),
//       e['title'].toString(),
//       e['body'].toString(),
//       e['create_date'].toString(),
//       e['stock_symbol'].toString()
//   )).toList();
// }

}