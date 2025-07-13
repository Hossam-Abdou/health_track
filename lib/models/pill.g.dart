// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PillAdapter extends TypeAdapter<Pill> {
  @override
  final int typeId = 1;

  @override
  Pill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pill(
      name: fields[0] as String,
      dosage: fields[1] as String,
      schedule: fields[2] as String,
      iconCodePoint: fields[3] as int,
      imagePath: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Pill obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dosage)
      ..writeByte(2)
      ..write(obj.schedule)
      ..writeByte(3)
      ..write(obj.iconCodePoint)
      ..writeByte(4)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
