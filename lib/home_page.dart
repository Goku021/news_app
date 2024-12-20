import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/news_bloc.dart';
import 'package:news_app/webscreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Future<void> _launchUrl(String newsUrl) async {
  //   final Uri uri = Uri.parse(newsUrl);
  //   if (!await launchUrl(uri)) {
  //     throw Exception("Couldnt launch url $newsUrl");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily News"),
      ),
      drawer: Drawer(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<NewsBloc>()
                            .add(FetchNewsAccToCategory("science"));
                      },
                      child: Text("Science")),
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<NewsBloc>()
                            .add(FetchNewsAccToCategory("sports"));
                      },
                      child: Text("Sports")),
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<NewsBloc>()
                            .add(FetchNewsAccToCategory("entertainment"));
                      },
                      child: Text("Entertainment")),
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<NewsBloc>()
                            .add(FetchNewsAccToCategory("technology"));
                      },
                      child: Text("Technology")),
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<NewsBloc>()
                            .add(FetchNewsAccToCategory("health"));
                      },
                      child: Text("Health"))
                ],
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
                if (state is NewsLoadedState) {
                  return ListView.builder(
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        final article = state.articles[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Stack(
                            children: [
                              article.articleImage != null &&
                                      article.articleImage.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child:
                                          Image.network(article.articleImage))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.network(
                                          width: double.infinity,
                                          "http://ts1.mm.bing.net/th?id=OIP.dQMUz_t9WflFGGDph-cfsAHaE8&pid=15.1"),
                                    ),
                              Positioned(
                                left: 15,
                                bottom: 10,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withAlpha(244),
                                          Colors.transparent.withAlpha(0)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        width: 200,
                                        // Adjust width to fit your layout
                                        child: Text(
                                          article.articleTitle.length > 50
                                              ? '${article.articleTitle.substring(0, 55)}...'
                                              : article.articleTitle,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                          // Adds "..." automatically for overflow
                                          maxLines: 4, // Ensures a line break
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return WebScreen(
                                                      article.articleUrl);
                                                },
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                              fixedSize: Size(90, 20),
                                              backgroundColor: Colors.white),
                                          child: Text(
                                            "Read More",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                } else if (state is NewsLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NewsErrorState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return Center(
                    child: Text("Select Categories to fetch Newss...."),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
