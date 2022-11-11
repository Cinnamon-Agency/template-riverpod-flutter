import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../models/api_error/api_error.dart';
import '../../../models/movie/movie.dart';
import '../../../theme/theme.dart';
import '../controllers/home_controller.dart';
import '../widgets/movie_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieListValue = ref.watch(homeControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        title: Text(
          'appName'.tr(),
          style: AppTextStyles.bold,
        ),
      ),
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Center(
            child: movieListValue.when(
              data: (movies) => HomePageContents(data: movies),
              loading: () => const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.secondary),
                ),
              ),
              error: (e, __) => Text(
                (e as ApiError).message,
                textAlign: TextAlign.center,
                style: AppTextStyles.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePageContents extends ConsumerWidget {
  const HomePageContents({
    required this.data,
    Key? key,
  }) : super(key: key);

  final List<Movie> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) => RefreshIndicator(
        displacement: 10,
        backgroundColor: AppColors.white,
        color: AppColors.primary,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: ref.read(homeControllerProvider.notifier).getMovies,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const PaginationWidget(),
              AnimationLimiter(
                child: GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 180,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: 3,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: MovieWidget(movie: data[index]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class PaginationWidget extends ConsumerWidget {
  const PaginationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: ref.watch(currentPageProvider) == 1 ? 0.2 : 1,
            child: IconButton(
              onPressed: () {
                if (ref.read(currentPageProvider) == 1) {
                  return;
                }
                ref.read(currentPageProvider.notifier).state--;
                ref.read(homeControllerProvider.notifier).getMovies();
              },
              icon: const Icon(Icons.chevron_left),
            ),
          ),
          Text('${ref.watch(currentPageProvider)} ... ${ref.watch(totalPagesProvider)}'),
          Opacity(
            opacity: ref.watch(currentPageProvider) == ref.watch(totalPagesProvider) ? 0.2 : 1,
            child: IconButton(
              onPressed: () {
                if (ref.read(currentPageProvider) == ref.read(totalPagesProvider)) {
                  return;
                }
                ref.read(currentPageProvider.notifier).state++;
                ref.read(homeControllerProvider.notifier).getMovies();
              },
              icon: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      );
}
