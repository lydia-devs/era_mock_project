part of 'article_details_bloc.dart';

@freezed
class ArticleDetailsEvent with _$ArticleDetailsEvent {
  const factory ArticleDetailsEvent.fetch(String id) = _Fetch;
}
