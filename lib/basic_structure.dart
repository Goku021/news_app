import 'package:dio/dio.dart';

class Articles {
  String articleTitle;
  String articleImage;
  String articleUrl;

  Articles(
      {required this.articleTitle,
      required this.articleImage,
      required this.articleUrl});

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      articleTitle: json['title'] ?? "",
      articleImage: json['urlToImage'] ?? "",
      articleUrl: json['url'] ?? "",
    );
  }
}

class ArticlesRepository {
  final Dio _dio = Dio();

  Future<List<Articles>> fetchNews({required String newsCategory}) async {
    try {
      final String url =
          "https://newsapi.org/v2/top-headlines?country=us&category=$newsCategory&apiKey=${your_api_key}";
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List articles = response.data['articles'];
        return articles.map((json) => Articles.fromJson(json)).toList();
      } else {
        return throw Exception("Failed to Fetch Data , is from fetch function");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to fetch newss.. ${e.toString()}");
    }
  }
}
