// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'providers/locale_provider.dart';
import 'providers/providers_logger.dart';
import 'providers/services_providers.dart';
import 'router/app_router.dart';
import 'services/device_info/device_info_service.dart';
import 'services/storage/hive_storage_service.dart';
import 'theme/theme.dart';

/// Function first called when running the project
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // To load the .env file contents into dotenv
  await dotenv.load();

  /// Removes hash from the Web routes
  usePathUrlStrategy();

  /// Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  /// Initialize Hive
  await Hive.initFlutter();
  final hiveStorageService = HiveStorageService();
  await hiveStorageService.openBox('template_app');

  final deviceInfoService = DeviceInfoService();
  await deviceInfoService.initProperInfo();

  /// Initialize Firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  /// Run the `CinnamonRiverpodTemplateApp` app
  runApp(
    ProviderScope(
      observers: [ProvidersLogger()],
      overrides: [
        storageServiceProvider.overrideWithValue(hiveStorageService),
        deviceInfoServiceProvider.overrideWithValue(deviceInfoService),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('hr')],
        path: 'assets/translations',
        useOnlyLangCode: true,
        fallbackLocale: const Locale('en'),
        child: CinnamonRiverpodTemplateApp(),
      ),
    ),
  );
}

/// Starting point of our Flutter application
class CinnamonRiverpodTemplateApp extends StatelessWidget {
  CinnamonRiverpodTemplateApp({super.key});

  AppRouter? router;

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        /// Size of the device the designer uses in their designs on Figma
        designSize: const Size(412, 732),
        builder: (_, __) => Consumer(
          builder: (context, ref, child) {
            router ??= AppRouter(ref);

            return MaterialApp.router(
              onGenerateTitle: (_) => 'appName'.tr(),
              debugShowCheckedModeBanner: false,
              routerDelegate: router!.appRouter.routerDelegate,
              routeInformationParser: router!.appRouter.routeInformationParser,
              routeInformationProvider: router!.appRouter.routeInformationProvider,
              theme: AppThemes.primary(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: ref.watch(localeProvider).toLocale(),
            );
          },
        ),
      );
}
