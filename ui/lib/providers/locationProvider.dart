import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wijha/models/Locations/Location.dart';

class LocationProvider extends StateNotifier<List<Location>> {
  LocationProvider() : super([]);

  void initLocations(List<Location> locations) {
    state = locations;
  }

  getLocation() {
    return state;
  }

  addLocation(Location location) {
    state.add(location);
  }

  deleteLocation(Location location) {
    state.remove(location);
  }
}

final locationProvider =
    StateNotifierProvider<LocationProvider, List<Location>>(
        (ref) => LocationProvider());
