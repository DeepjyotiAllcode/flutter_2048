import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2048/managers/board.dart';
import 'package:flutter_2048/models/tile.dart';
import 'package:flutter_2048/service/provider/game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import '../const/colors.dart';

class EmptyBoardWidget extends StatelessWidget {
  const EmptyBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //Decides the maximum size the Board can be based on the shortest size of the screen.
    final size = max(
        290.0,
        min((MediaQuery.of(context).size.shortestSide * 0.90).floorToDouble(),
            460.0));

    //Decide the size of the tile based on the size of the board minus the space between each tile.
    final sizePerTile = (size / 4).floorToDouble();
    final tileSize = sizePerTile - 12.0 - (12.0 / 4);
    final boardSize = sizePerTile * 4;
    return Container(
      width: boardSize,
      height: boardSize,
      decoration: BoxDecoration(
          color: boardColor, borderRadius: BorderRadius.circular(6.0)),
      child: Stack(
        children: List.generate(16, (i) {
          //Render the empty board in 4x4 GridView
          var x = ((i + 1) / 4).ceil();
          var y = x - 1;

          var top = y * (tileSize) + (x * 12.0);
          var z = (i - (4 * y));
          var left = z * (tileSize) + ((z + 1) * 12.0);

          return Positioned(
            top: top,
            left: left,
            child: Container(
              width: tileSize,
              height: tileSize,
              decoration: BoxDecoration(
                  color: emptyTileColor,
                  borderRadius: BorderRadius.circular(6.0)),
            ),
          );
        }),
      ),
    );
  }
}

class EmptyBoardTransparent extends ConsumerWidget {
  const EmptyBoardTransparent(this.moveAnimation, {super.key});
  final AnimationController moveAnimation;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Decides the maximum size the Board can be based on the shortest size of the screen.
    final size = max(
        290.0,
        min((MediaQuery.of(context).size.shortestSide * 0.90).floorToDouble(),
            460.0));

    //Decide the size of the tile based on the size of the board minus the space between each tile.
    final sizePerTile = (size / 4).floorToDouble();
    final tileSize = sizePerTile - 12.0 - (12.0 / 4);
    final boardSize = sizePerTile * 4;
    TodosNotifier todos = ref.read(todosProvider);
    onUpdate().listen((event) {
      if (ref.read(todosProvider).isRun) {
        print("object");
      }
    });
    final board = ref.watch(boardManager);
    return Container(
      width: boardSize,
      height: boardSize,
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(6.0)),
      child: Stack(
        children: List.generate(16, (i) {
          //Render the empty board in 4x4 GridView
          var x = ((i + 1) / 4).ceil();
          var y = x - 1;
          var top = y * (tileSize) + (x * 12.0);
          var z = (i - (4 * y));
          var left = z * (tileSize) + ((z + 1) * 12.0);

          return Positioned(
            top: top,
            left: left,
            child: GestureDetector(
              onTap: () async {
                ref.read(todosProvider).isRun = false;
                ref.read(boardManager.notifier).merge(i, todos.nextList[0]);
                if (ref.read(boardManager.notifier).move(SwipeDirection.up)) {
                  moveAnimation.forward(from: 0.0);
                }
                todos.generateNew();
                // print(board.tiles.map((e) => e.index).toList());
                // print(board.tiles.map((e) => e.value).toList());
                // ref.read(boardManager.notifier).mergeAll(i, todos.nextList[0]);
                // if (ref.read(boardManager.notifier).move(SwipeDirection.up)) {
                //   moveAnimation.forward(from: 0.0);
                // }
                // print(board.tiles[0].id);
              },
              child: Container(
                width: tileSize,
                height: tileSize,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(6.0)),
              ),
            ),
          );
        }),
      ),
    );
  }
}
