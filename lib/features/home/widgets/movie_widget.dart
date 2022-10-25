import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/movie/movie.dart';
import '../../../router/router_context_extension.dart';
import '../../../theme/theme.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({
    required this.movie,
    Key? key,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.pushDetailPage(
          args: movie,
          id: movie.id.toString(),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: movie.poster != null
                    ? CachedNetworkImage(
                        imageUrl: AppImages.instance.networkImagesPath + movie.poster!,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: AppColors.lightGray,
                          highlightColor: AppColors.darkerGray,
                          child: Container(
                            color: AppColors.white,
                          ),
                        ),
                      )
                    : Center(child: Text('noPoster'.tr())),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              movie.title,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.p1,
            ),
          ],
        ),
      );
}
