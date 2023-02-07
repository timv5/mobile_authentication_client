import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewsWidget extends StatelessWidget {

  final int userId;
  final int id;
  final String title;
  final String body;

  const NewsWidget(this.userId, this.id, this.title, this.body, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(title),
          subtitle: Text(body),
        ),
      ),
    );
  }
}
