part of 'news_bloc.dart';

@freezed
class NewsEvent with _$NewsEvent {
  const factory NewsEvent.fetchAllArticles() = _FetchArticle;
  const factory NewsEvent.markAllRead() = _MarkAllRead;
}
