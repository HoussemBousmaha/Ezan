import 'package:hooks_riverpod/hooks_riverpod.dart';

class Expences extends StateNotifier<List<int>> {
  Expences() : super([1000, 2000, 2500, 1500, 500, 200, 890]);

  void modifyExpence(int day, int newAmount) {
    final newState = List.generate(
      state.length,
      (index) {
        return day == index ? newAmount : state[index];
      },
    );
    state = newState;
  }
}

final expencesProvider = StateNotifierProvider<Expences, List<int>>((ref) {
  return Expences();
});
