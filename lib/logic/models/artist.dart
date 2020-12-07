import 'package:flutter/foundation.dart';

class Artist {
  final String id;
  final String name;
  final String imgUrl;

  const Artist({
    @required this.id,
    @required this.name,
    @required this.imgUrl,
  });

  @override
  bool operator ==(other) => other is Artist && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
