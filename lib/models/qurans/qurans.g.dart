// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qurans.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuransAdapter extends TypeAdapter<Qurans> {
  @override
  final int typeId = 0;

  @override
  Qurans read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Qurans(
      number: fields[0] as num?,
      text: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Qurans obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuransAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
