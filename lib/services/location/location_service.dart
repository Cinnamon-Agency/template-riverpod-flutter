/// Abstract class defining [LocationService] structure
abstract class LocationService {
  /// Get current location of the device
  Future<dynamic> getDeviceLocation();
}
