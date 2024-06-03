import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:era_developers_test_flutter/repositories/news/repository.dart';
import 'package:era_developers_test_flutter/router/app_router.dart';
import 'package:era_developers_test_flutter/theming/app_colors.dart';
import 'package:era_developers_test_flutter/theming/app_text_styles.dart';
import 'package:flutter/material.dart';

class FeaturedArticles extends StatelessWidget {
  final List<Article> articles;

  const FeaturedArticles({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 300,
          viewportFraction: 1,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
        ),
        items: articles.map((article) {
          return GestureDetector(
            onTap: () {
              context.router.push(ArticleDetailsRoute(id: article.id));
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25), // 25% opacity
                    blurRadius: 20,
                    offset: const Offset(4, 4),
                    spreadRadius: 20,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      width: MediaQuery.of(context).size.width,
                      article.imageUrl,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(left: 20, bottom: 40),
                    child: Text(
                      article.title,
                      style: AppTextStyles.txt28w400
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
