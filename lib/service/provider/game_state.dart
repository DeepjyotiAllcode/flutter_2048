import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodosNotifier extends ChangeNotifier {
  List generateList = [2, 4, 8, 16, 32, 64];
  List nextList = [2, 4];
  bool _isRun = false;
  bool get isRun => _isRun;
  void generateNew() {
    nextList.remove(nextList[0]);
    nextList.add(generateList[Random().nextInt(generateList.length)]);
    notifyListeners();
  }

  set isRun(bool isRun) {
    _isRun = isRun;
    notifyListeners();
  }
}

final todosProvider = ChangeNotifierProvider<TodosNotifier>((ref) {
  return TodosNotifier();
});
Stream<int> onUpdate() async* {
  yield* Stream.periodic(const Duration(milliseconds: 1),
      (computationCount) => computationCount++);
}
