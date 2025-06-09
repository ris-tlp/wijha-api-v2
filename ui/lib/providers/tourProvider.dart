import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wijha/models/Tours/Tour.dart';
import 'package:wijha/models/Users/Tourist.dart';
import '../data.dart';
import '../models/Users/Guide.dart';

class TourProvider extends StateNotifier<List<Tour>> {
  TourProvider() : super(toursData);
  bool init = false;
  void add(Tour tour) => {state.add(tour)};
  getTours() {
    return state.where((tour) => tour.status == 0).toList();
  }

  getToursByGuide(Guide guide) {
    return state
        .where((tour) =>
            tour.guide == guide && (tour.status == 0 || tour.status == 1))
        .toList();
  }

  getEndedToursByGuide(Guide guide) {
    return state
        .where((tour) => tour.guide == guide && (tour.status == -1))
        .toList();
  }

  getToursByTourist(Tourist tourist) {
    return state
        .where((tour) =>
            tour.registrationRequests
                .map((registration) => registration.user)
                .contains(tourist) &&
            (tour.status == 0 || tour.status == 1))
        .toList();
  }

  getEndedToursByTourist(Tourist tourist) {
    return state
        .where((tour) =>
            tour.registrationRequests
                .map((registration) => registration.user)
                .contains(tourist) &&
            (tour.status == -1))
        .toList();
  }

  /// For the demo only
  getActiveTours() {
    return state.where((tour) => tour.status == 0 || tour.status == 1).toList();
  }
}

final tourProvider =
    StateNotifierProvider<TourProvider, List<Tour>>((ref) => TourProvider());
