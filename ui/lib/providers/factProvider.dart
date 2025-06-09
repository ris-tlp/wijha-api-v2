import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wijha/models/Notifications/Fact.dart';

class FactProvider extends StateNotifier<List<Fact>> {
  FactProvider() : super([]);

  void initFacts(List<Fact> facts) {
    state = facts;
  }

  getFacts() {
    return state;
  }

  addFact(Fact fact) {
    state.add(fact);
  }

  deleteFact(Fact fact) {
    state.remove(fact);
  }
}

final factProvider =
    StateNotifierProvider<FactProvider, List<Fact>>((ref) => FactProvider());
