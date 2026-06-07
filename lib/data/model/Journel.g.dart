// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Journel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournelAdapter extends TypeAdapter<Journel> {
  @override
  final int typeId = 0;

  @override
  Journel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Journel(
      id: fields[0] as int,
      title: fields[1] as String,
      suggestedMoods: (fields[3] as List).cast<String>(),
      duration: fields[4] as int,
      descrption: fields[5] as String, color: Color(fields[2] as int),
    )..colorValue = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, Journel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.colorValue)
      ..writeByte(3)
      ..write(obj.suggestedMoods)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.descrption);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
