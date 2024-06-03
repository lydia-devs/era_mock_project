import 'package:auto_route/annotations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:era_developers_test_flutter/presentation/news/widgets/featured_article_tile.dart';
import 'package:era_developers_test_flutter/components/sized_box.dart';
import 'package:era_developers_test_flutter/presentation/news/bloc/news_bloc.dart';
import 'package:era_developers_test_flutter/presentation/news/widgets/latest_news_tile.dart';
import 'package:era_developers_test_flutter/theming/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late final bloc = context.read<NewsBloc>();

  @override
  void initState() {
    bloc.add(NewsEvent.fetchAllArticles());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: const Text('Notifications', style: AppTextStyles.text4),
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.only(left: 0, right: 20),
            child: SvgPicture.asset(
              'assets/icons/arrow_back.svg',
              height: 24,
            ),
          ),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                bloc.add(const NewsEvent.markAllRead());
              },
              child: const Text('Mark all read'),
            ),
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) =>
                  const Center(child: Text('Error fetching data')),
              loaded: (featuredArticles, latestArticles) {
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text('Featured', style: AppTextStyles.txt20w400),
                    ),
                    HBox(20),
                    FeaturedArticles(articles: featuredArticles),
                    HBox(20),
                    const Text('Latest News', style: AppTextStyles.txt20w400),
                    HBox(20),
                    for (int i = 0; i < latestArticles.length; i++) ...[
                      LatestNewsTile(latestArticle: latestArticles[i]),
                      HBox(20),
                    ],
                  ],
                );
              });
        },
      ),
    );
  }
}
