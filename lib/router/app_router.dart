import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../presentation/article_details/pages/article_details_page.dart';
import '../presentation/news/pages/news_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NewsRoute.page, path: '/'),
        AutoRoute(page: ArticleDetailsRoute.page, path: '/article_details'),
      ];
}
