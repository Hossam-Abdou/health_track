// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicalFileAdapter extends TypeAdapter<MedicalFile> {
  @override
  final int typeId = 0;

  @override
  MedicalFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicalFile(
      name: fields[0] as String,
      date: fields[1] as String,
      iconCodePoint: fields[2] as int,
      filePath: fields[3] as String,
      notes: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MedicalFile obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.iconCodePoint)
      ..writeByte(3)
      ..write(obj.filePath)
      ..writeByte(4)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicalFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
