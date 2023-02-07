import 'dart:convert';

import 'package:http/http.dart' as http;

import '../dto/news.dart';

class NewsService {

  Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=3'));
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<News>.from(l.map((model)=> News.fromJson(model)));
    } else {
      throw Exception("failed to get a response");
    }
  }

}