import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:era_developers_test_flutter/components/sized_box.dart';
import 'package:era_developers_test_flutter/presentation/article_details/bloc/article_details_bloc.dart';
import 'package:era_developers_test_flutter/theming/app_colors.dart';
import 'package:era_developers_test_flutter/theming/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class ArticleDetailsPage extends StatefulWidget {
  final String id;

  const ArticleDetailsPage({super.key, required this.id});

  @override
  State<ArticleDetailsPage> createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  late final bloc = context.read<ArticleDetailsBloc>();

  @override
  void initState() {
    bloc.add(ArticleDetailsEvent.fetch(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<ArticleDetailsBloc, ArticleDetailsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) =>
                  const Center(child: Text('Error fetching data')),
              loaded: (article) {
                return ListView(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                          ),
                          height: 900,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: Column(
                            children: [
                              HBox(515),
                              Container(
                                child: Text(
                                  article.description ?? '',
                                  style: AppTextStyles.text2
                                      .copyWith(height: 19 / 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 495,
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                // 25% opacity
                                offset: Offset(4, 4),
                                blurRadius: 20,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12)),
                            child: Image.network(
                              article.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 0, right: 20),
                              child: SvgPicture.asset(
                                'assets/icons/arrow_back.svg',
                                colorFilter: ColorFilter.mode(
                                  AppColors.white,
                                  BlendMode.srcIn,
                                ),
                                height: 24,
                              ),
                            ),
                            onPressed: () {
                              context.router.pop();
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 48, top: 380),
                          child: Text(
                            article.title,
                            style: AppTextStyles.txt28w400
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
