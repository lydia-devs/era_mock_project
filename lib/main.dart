import 'package:era_developers_test_flutter/presentation/article_details/bloc/article_details_bloc.dart';
import 'package:era_developers_test_flutter/presentation/news/bloc/news_bloc.dart';
import 'package:era_developers_test_flutter/presentation/news/pages/news_page.dart';
import 'package:era_developers_test_flutter/repositories/news/mock_news_repository.dart';
import 'package:era_developers_test_flutter/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(ForestVPNTestApp());
}

class ForestVPNTestApp extends StatelessWidget {
  ForestVPNTestApp({Key? key}) : super(key: key);
  MockNewsRepository api = MockNewsRepository();
  AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsBloc(api)),
        BlocProvider(create: (context) => ArticleDetailsBloc(api)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'ForestVPN test',
        routerConfig: appRouter.config(),
      ),
    );
  }
}
