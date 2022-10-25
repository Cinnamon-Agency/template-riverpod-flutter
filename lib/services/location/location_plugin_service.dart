import 'package:location/location.dart';

import '../logger/logger_service.dart';
import 'location_service.dart';

/// Implementation of [LocationService] with [Location]
class LocationPluginService implements LocationService {
  LocationPluginService(this.logger);

  final LoggerService logger;

  @override
  Future<LocationData?> getDeviceLocation() async {
    final locationInstance = Location();

    bool? serviceEnabled;
    PermissionStatus? permission;

    try {
      serviceEnabled = await locationInstance.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await locationInstance.requestService();
        if (!serviceEnabled) {
          logger
            ..e('LOCATION')
            ..e('--------------------')
            ..e('Location not enabled')
            ..e('--------------------\n');
          return null;
        }
      }
      permission = await locationInstance.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await locationInstance.requestPermission();
        if (permission == PermissionStatus.denied) {
          logger
            ..e('LOCATION')
            ..e('--------------------')
            ..e('Location permission denied')
            ..e('--------------------\n');
          return null;
        }
      }

      if (permission == PermissionStatus.deniedForever) {
        logger
          ..e('LOCATION')
          ..e('--------------------')
          ..e('Location permission denied forever')
          ..e('--------------------\n');
        return null;
      }

      await locationInstance.changeSettings(accuracy: LocationAccuracy.balanced);

      final locationData = await locationInstance.getLocation();

      if (locationData.latitude != null && locationData.longitude != null) {
        logger
          ..v('LOCATION')
          ..v('--------------------')
          ..v('Location fetched')
          ..v('$locationData')
          ..v('--------------------\n');

        return locationData;
      }

      // logger
      //   ..e('LOCATION')
      //   ..e('--------------------')
      //   ..e('Location data is null')
      //   ..e('--------------------\n');
      return null;
    } catch (e) {
      // logger
      //   ..e('LOCATION')
      //   ..e('--------------------')
      //   ..e('Location error')
      //   ..e('$e')
      //   ..e('--------------------\n');
    }

    return null;
  }
}
