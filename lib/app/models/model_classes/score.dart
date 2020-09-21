import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/model_classes/chord.dart';
import 'package:sky_score_generator/util/extensions/extensions_exporter.dart';

class Score {
  const Score({
    @required this.id,
    @required this.title,
    @required this.chords,
    @required this.createdAt,
  });

  final String id;
  final String title;
  final List<Chord> chords;
  final DateTime createdAt;

  Score copyWith({
    String id,
    String title,
    List<Chord> chords,
    DateTime createdAt,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (title == null || identical(title, this.title)) &&
        (chords == null || identical(chords, this.chords)) &&
        (createdAt == null || identical(createdAt, this.createdAt))) {
      return this;
    }

    return new Score(
      id: id ?? this.id,
      title: title ?? this.title,
      chords: chords ?? this.chords,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Score{id: $id, title: $title, chords: $chords, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Score &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          chords == other.chords &&
          createdAt == other.createdAt);

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ chords.hashCode ^ createdAt.hashCode;

  factory Score.fromMap(Map<String, dynamic> map) {
    return new Score(
      id: map['id'] as String,
      title: map['title'] as String,
      chords: _convertToChordList(map['chords']),
      createdAt:
          DateTimeExtensions.fromTimestamp(map['createdAt'] as Timestamp),
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'title': this.title,
      'chords': _convertToChordDataList(this.chords),
      'createdAt': this.createdAt.toTimestamp(),
    } as Map<String, dynamic>;
  }

  List<Map<String, dynamic>> _convertToChordDataList(List<Chord> chords) {
    final list = <Map<String, dynamic>>[];

    chords.forEach((chord) {
      list.add(chord.toMap());
    });
    return list;
  }

  static List<Chord> _convertToChordList(dynamic list) {
    if (list == null) {
      return null;
    }
    final List<Map> softCasted = (list as List).cast<Map>();

    final List<Chord> resultList = [];
    softCasted.forEach((data) {
      final castedData = data.cast<String, dynamic>();
      resultList.add(Chord.fromMap(castedData));
    });

    return resultList;
  }
}
