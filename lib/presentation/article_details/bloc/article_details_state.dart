part of 'article_details_bloc.dart';

@freezed
class ArticleDetailsState with _$ArticleDetailsState {
  const factory ArticleDetailsState.initial() = _Initial;
  const factory ArticleDetailsState.loading() = _Loading;
  const factory ArticleDetailsState.error(String message) = _Error;
  const factory ArticleDetailsState.loaded(Article article) = _Loaded;
}
