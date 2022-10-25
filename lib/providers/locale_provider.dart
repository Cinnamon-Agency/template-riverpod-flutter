import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/storage/storage_service.dart';
import 'services_providers.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, String>((ref) {
  final storageService = ref.watch(storageServiceProvider);

  /// Get locale from local storage if it exists.
  /// If not, use platform locale if it's supported.
  /// If not, use fallback locale
  /// If an error occurs, use fallback locale
  late String initialLocale;

  try {
    initialLocale = storageService.getValue(StorageKeys.currentLocale) ?? Platform.localeName.substring(0, 2);
  } catch (e) {
    log('Error setting initial locale: $e');
    initialLocale = 'en';
  }

  return LocaleNotifier(
    storageService,
    initialLocale: initialLocale,
  );
});

class LocaleNotifier extends StateNotifier<String> {
  LocaleNotifier(
    this.storageServiceProvider, {
    required String initialLocale,
  }) : super(initialLocale);

  final StorageService storageServiceProvider;

  /// Get current locale
  String get language => state;

  /// Change locale in state and store it in the local storage
  void setLocale(String localeCode) {
    state = localeCode;
    storageServiceProvider.setValue(
      key: StorageKeys.currentLocale,
      data: localeCode,
    );
  }
}
