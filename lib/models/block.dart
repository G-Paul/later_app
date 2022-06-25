import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

final String tableName = 'linkTable';

class BlockFields {
  static final List<String> values = [id, title, url, date];

  static final String id = '_id';
  static final String title = 'title';
  static final String url = 'url';
  static final String date = 'date';
}

class Block {
  final int? id;
  final String title;
  final String url;
  final DateTime date;

  const Block(
      {this.id, required this.title, required this.url, required this.date});

  static Block fromRow(Map<String, Object?> row) => Block(
        id: row[BlockFields.id] as int?,
        title: row[BlockFields.title] as String,
        url: row[BlockFields.url] as String,
        date: DateTime.parse(row[BlockFields.date] as String),
      );

  Map<String, Object?> toRow() => {
        BlockFields.id: id,
        BlockFields.title: title,
        BlockFields.url: url,
        BlockFields.date: date.toIso8601String(),
      };
  Block copy({
    int? id,
    String? title,
    String? url,
    DateTime? date,
  }) =>
      Block(
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        date: date ?? this.date,
      );
}
