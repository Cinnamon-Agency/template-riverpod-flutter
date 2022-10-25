import 'package:geolocator/geolocator.dart';

import '../logger/logger_service.dart';
import 'location_service.dart';

/// Implementation of [LocationService] with [Geolocator]
class GeolocatorPluginService implements LocationService {
  GeolocatorPluginService(this.logger);

  final LoggerService logger;

  @override
  Future<Position?> getDeviceLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        logger
          ..e('LOCATION')
          ..e('--------------------')
          ..e('Location not enabled')
          ..e('--------------------\n');
        return null;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          logger
            ..e('LOCATION')
            ..e('--------------------')
            ..e('Location permission denied')
            ..e('--------------------\n');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        logger
          ..e('LOCATION')
          ..e('--------------------')
          ..e('Location permission denied forever')
          ..e('--------------------\n');
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        timeLimit: const Duration(seconds: 60),
        desiredAccuracy: LocationAccuracy.high,
      );

      logger
        ..v('LOCATION')
        ..v('--------------------')
        ..v('Location fetched')
        ..v('$position')
        ..v('--------------------\n');

      return position;
    } catch (e) {
      logger
        ..e('LOCATION')
        ..e('--------------------')
        ..e('Location error')
        ..e('$e')
        ..e('--------------------\n');
    }
    return null;
  }
}
