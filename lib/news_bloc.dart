import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/basic_structure.dart';

abstract class NewsEvent {}

class FetchTopHeadlines extends NewsEvent {}

class FetchNewsAccToCategory extends NewsEvent {
  final String category;

  FetchNewsAccToCategory(this.category);
}

abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<Articles> articles;

  NewsLoadedState(this.articles);
}

class NewsErrorState extends NewsState {
  String errorMessage;

  NewsErrorState(this.errorMessage);
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ArticlesRepository articlesRepo;

  NewsBloc(this.articlesRepo) : super(NewsInitialState()) {
    on<FetchTopHeadlines>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final articles = await articlesRepo.fetchNews(newsCategory: "business");
        emit(NewsLoadedState(articles));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });
    on<FetchNewsAccToCategory>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final articles =
            await articlesRepo.fetchNews(newsCategory: event.category);
        emit(NewsLoadedState(articles));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });
  }
}
