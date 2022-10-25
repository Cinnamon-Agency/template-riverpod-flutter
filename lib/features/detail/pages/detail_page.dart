import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/theme.dart';
import '../../../models/api_error/api_error.dart';
import '../../../models/detail_page_args.dart';
import '../controllers/detail_page_controller.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({
    required this.args,
    super.key,
  });

  final DetailPageArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailPageController = ref.watch(detailPageControllerProvider(args));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        title: Text(
          detailPageController.hasValue ? detailPageController.value!.title : 'Movie',
          style: AppTextStyles.bold,
        ),
      ),
      body: SafeArea(
          child: detailPageController.when(
        data: (data) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (data.poster != null) ...[
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: CachedNetworkImage(
                      imageUrl: AppImages.instance.networkImagesPath + data.poster!,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                Text(data.overview),
              ],
            ),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColors.secondary),
          ),
        ),
        error: (e, __) => Center(
          child: Text(
            e is ApiError ? e.message : e.toString(),
            textAlign: TextAlign.center,
            style: AppTextStyles.bold,
          ),
        ),
      )),
    );
  }
}
