abstract class BaseAppImages {
  String imagesPath = '';
  String networkImagesPath = '';

  /// Define local assets
  String get cinnamonLogo => '$imagesPath/cinnamon_logo.png';
}

class AppImages extends BaseAppImages {
  factory AppImages() => instance;
  AppImages._();
  static AppImages instance = AppImages._();

  @override
  String get imagesPath => 'assets/images';

  @override
  String get networkImagesPath => 'https://image.tmdb.org/t/p/w500/';
}
