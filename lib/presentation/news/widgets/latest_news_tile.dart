import 'package:auto_route/auto_route.dart';
import 'package:era_developers_test_flutter/components/sized_box.dart';
import 'package:era_developers_test_flutter/repositories/news/models/article.dart';
import 'package:era_developers_test_flutter/router/app_router.dart';
import 'package:era_developers_test_flutter/theming/app_colors.dart';
import 'package:era_developers_test_flutter/theming/app_text_styles.dart';
import 'package:flutter/material.dart';

class LatestNewsTile extends StatelessWidget {
  final Article latestArticle;

  const LatestNewsTile({super.key, required this.latestArticle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(ArticleDetailsRoute(id: latestArticle.id));
      },
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 23, left: 20, right: 20),
        height: 103,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25), // 25% opacity
              offset: Offset(4, 4),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(9)),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 60,
              width: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  latestArticle.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            WBox(23),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    latestArticle.title,
                    style: AppTextStyles.text2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  HBox(11),
                  Text(
                    timeAgo(latestArticle.publicationDate),
                    style:
                        AppTextStyles.txt12w400.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
            ),
            if (latestArticle.readed)
              const Icon(Icons.done, color: Colors.green),
          ],
        ),
      ),
    );
  }
}

String timeAgo(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays > 1) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays == 1) {
    return '1 day ago';
  } else if (difference.inHours >= 1) {
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} minutes ago';
  } else {
    return 'Just now';
  }
}
