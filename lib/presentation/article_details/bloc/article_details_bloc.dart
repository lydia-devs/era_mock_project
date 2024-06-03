import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../repositories/news/mock_news_repository.dart';
import '../../../repositories/news/models/article.dart';

part 'article_details_event.dart';
part 'article_details_state.dart';
part 'article_details_bloc.freezed.dart';

class ArticleDetailsBloc
    extends Bloc<ArticleDetailsEvent, ArticleDetailsState> {
  MockNewsRepository api = MockNewsRepository();

  ArticleDetailsBloc(this.api) : super(const _Initial()) {
    on<ArticleDetailsEvent>((event, emit) async {
      await event.when(
        fetch: (id) async {
          emit(const _Loading());
          try {
            final articles = await api.getArticle(id);

            emit(_Loaded(articles));
          } catch (e) {
            log(e.toString(), name: 'ArticleDetails Bloc Fetch');
            emit(_Error(e.toString()));
          }
        },
      );
    });
  }
}
