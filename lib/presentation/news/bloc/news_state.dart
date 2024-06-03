part of 'news_bloc.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState.initial() = _Initial;
  const factory NewsState.loading() = _Loading;
  const factory NewsState.error(String message) = _Error;
  const factory NewsState.loaded(List<Article> featuredArticles, List<Article> latestArticles) = _Loaded;
}
