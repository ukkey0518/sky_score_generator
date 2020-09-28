import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sky_score_generator/app/models/model_classes/chord.dart';
import 'package:sky_score_generator/util/extensions/extensions_exporter.dart';

class Score {
  const Score({
    @required this.id,
    @required this.title,
    @required this.chord,
    @required this.createdAt,
  });

  final String id;
  final String title;
  final List<Chord> chord;
  final DateTime createdAt;

  Score copyWith({
    String id,
    String title,
    List<Chord> chord,
    DateTime createdAt,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (title == null || identical(title, this.title)) &&
        (chord == null || identical(chord, this.chord)) &&
        (createdAt == null || identical(createdAt, this.createdAt))) {
      return this;
    }

    return new Score(
      id: id ?? this.id,
      title: title ?? this.title,
      chord: chord ?? this.chord,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Score{id: $id, title: $title, chord: $chord, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Score &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          chord == other.chord &&
          createdAt == other.createdAt);

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ chord.hashCode ^ createdAt.hashCode;

  factory Score.fromMap(Map<String, dynamic> map) {
    return new Score(
      id: map['id'] as String,
      title: map['title'] as String,
      chord: _convertToChordList(map['chord']),
      createdAt:
          DateTimeExtensions.fromTimestamp(map['createdAt'] as Timestamp),
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'title': this.title,
      'chord': _convertToBlob(this.chord),
      'createdAt': this.createdAt.toTimestamp(),
    } as Map<String, dynamic>;
  }

//</editor-fold>

}

List<Chord> _convertToChordList(dynamic chord) {
  if (chord == null) {
    return null;
  }

  final Blob blob = chord as Blob;
  final Uint8List uints = blob.bytes;

  final chordLength = (uints.length / 15).floor();

  List<Chord> list = [];
  for (var i = 0; i < chordLength; i++) {
    list.add(Chord(Uint8List.fromList(uints.sublist(i * 15, (i + 1) * 15))));
  }
  return list;
}

Blob _convertToBlob(List<Chord> chord) {
  if (chord == null) {
    return null;
  }

  final List<int> list = [];

  chord.forEach((chord) {
    list.addAll(chord.chord);
  });

  final uint = Uint8List.fromList(list);

  return Blob(uint);
}
