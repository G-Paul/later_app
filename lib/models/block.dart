import 'package:flutter/foundation.dart';

class Block {
  final String id;
  final String title;
  final String url;
  final DateTime date;

  const Block(
      {required this.id,
      required this.title,
      required this.url,
      required this.date});
}
