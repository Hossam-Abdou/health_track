// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisitAdapter extends TypeAdapter<Visit> {
  @override
  final int typeId = 2;

  @override
  Visit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Visit(
      doctor: fields[0] as String,
      date: fields[1] as String,
      reason: fields[2] as String,
      iconCodePoint: fields[3] as int,
      prescriptionImagePath: fields[4] as String?,
      notes: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Visit obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.doctor)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.reason)
      ..writeByte(3)
      ..write(obj.iconCodePoint)
      ..writeByte(4)
      ..write(obj.prescriptionImagePath)
      ..writeByte(5)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
