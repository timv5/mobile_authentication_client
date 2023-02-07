import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_authnetication_client/widget/news_widget.dart';
import '../dto/news.dart';
import '../service/news_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsScreen extends StatefulWidget {

  static const routeName = '/news';

  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  late Future<List<News>> futureNewsList;
  NewsService cryptoService = NewsService();

  @override
  void initState() {
    super.initState();
    futureNewsList = cryptoService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureNewsList,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if (dataSnapshot.hasData) {
            List<News> news = dataSnapshot.requireData;

            return ListView.builder(
                itemCount: news.length,
                itemBuilder: (BuildContext context, int index) => NewsWidget(
                    news[index].userId,
                    news[index].id,
                    news[index].title,
                    news[index].body
                )
            );
          } else {
            return Center(child: Text(AppLocalizations.of(context).noData),);
          }
        }
    );
  }
}
