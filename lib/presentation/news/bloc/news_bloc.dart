import 'dart:developer';
import 'package:era_developers_test_flutter/repositories/news/mock_news_repository.dart';
import 'package:era_developers_test_flutter/repositories/news/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_event.dart';

part 'news_state.dart';

part 'news_bloc.freezed.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  MockNewsRepository api = MockNewsRepository();

  NewsBloc(this.api) : super(const NewsState.initial()) {
    on<NewsEvent>((event, emit) async {
      await event.when(
        fetchAllArticles: () async {
          emit(const _Loading());
          try {
            final featuredArticles = await api.getFeaturedArticles();
            final latestArticles = await api.getLatestArticles();

            emit(_Loaded(latestArticles, featuredArticles));
          } catch (e) {
            log(e.toString(), name: 'News Bloc Fetch');
            emit(_Error(e.toString()));
          }
        },
        markAllRead: () {
          if (state is _Loaded) {
            final old = state as _Loaded;
            emit(const _Loading());
            List<Article> featuredArticles = old.featuredArticles;
            for (final article in featuredArticles) {
              article.read();
            }
            List<Article> latestArticles = old.latestArticles;
            for (final article in latestArticles) {
              article.read();
            }
            emit(old.copyWith(
              featuredArticles: featuredArticles,
              latestArticles: latestArticles,
            ));
          }
        },
      );
    });
  }
}
