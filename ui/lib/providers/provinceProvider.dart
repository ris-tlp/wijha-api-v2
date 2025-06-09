import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wijha/models/Locations/Province.dart';
import '../data.dart';

class ProvinceProvider extends StateNotifier<Province> {
  ProvinceProvider() : super(provinceData[0]);
  bool init = false;
  void change(Province province) => {state = province, init = true};
  getProvince() {
    return state;
  }
  bool isInit() {
    return init;
  }
}

final provinceProvider = StateNotifierProvider<ProvinceProvider, Province>(
    (ref) => ProvinceProvider());
