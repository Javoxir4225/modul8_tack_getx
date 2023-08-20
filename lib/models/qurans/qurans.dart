import 'dart:convert';

import 'package:hive/hive.dart';
part 'qurans.g.dart';

@HiveType(typeId: 0)
class Qurans {
  @HiveField(0)
  final num? number;
  @HiveField(1)
  final String? text;
  Qurans({
    this.number,
    this.text,
  });

  Qurans copyWith({
    num? number,
    String? text,
  }) {
    return Qurans(
      number: number ?? number,
      text: text ?? text,
    );
  }

  Qurans merge(Qurans model) {
    return Qurans(
      number: model.number ?? number,
      text: model.text ?? text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'text': text,
    };
  }

  factory Qurans.fromMap(Map<String, dynamic> map) {
    return Qurans(
      number: map['number'],
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Qurans.fromJson(String source) => Qurans.fromMap(json.decode(source));

  @override
  String toString() => 'Ayah(number: $number, text: $text)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Qurans && other.number == number && other.text == text;
  }

  @override
  int get hashCode => number.hashCode ^ text.hashCode;
}
