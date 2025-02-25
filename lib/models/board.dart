import 'package:json_annotation/json_annotation.dart';

import '../models/tile.dart';

part 'board.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class Board {
  //Current score on the board
  final int score;
  //Best score so far
  final int best;
  //Current list of tiles shown on the board
  final List<Tile> tiles;
  final List<int> random;
  final int nextSelected;
  //Whether the game is over or not
  final bool over;
  //Whether the game is won or not
  final bool won;
  //Keeps the previous round board state used for the undo functionality
  final Board? undo;

  Board(
    this.score,
    this.best,
    this.tiles, {
    this.over = false,
    this.won = false,
    this.undo,
    this.random = const [2, 4, 8, 16, 32, 64],
    this.nextSelected = 2,
  });

  //Create a model for a new game.
  Board.newGame(this.best, this.tiles)
      : score = 0,
        over = false,
        won = false,
        undo = null,
        random = const [2, 4, 8, 16, 32, 64],
        nextSelected = 2;

  //Create an immutable copy of the board
  Board copyWith({
    int? score,
    int? best,
    List<Tile>? tiles,
    bool? over,
    bool? won,
    Board? undo,
    List<int>? random,
    int? nextSelected,
  }) =>
      Board(
        score ?? this.score,
        best ?? this.best,
        tiles ?? this.tiles,
        over: over ?? this.over,
        won: won ?? this.won,
        undo: undo ?? this.undo,
        random: random ?? this.random,
        nextSelected: nextSelected ?? this.nextSelected,
      );

  //Create a Board from json data
  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  //Generate json data from the Board
  Map<String, dynamic> toJson() => _$BoardToJson(this);
}
