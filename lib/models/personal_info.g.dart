// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalInfoAdapter extends TypeAdapter<PersonalInfo> {
  @override
  final int typeId = 4;

  @override
  PersonalInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalInfo(
      name: fields[0] as String,
      dob: fields[1] as String,
      gender: fields[2] as String,
      bloodType: fields[3] as String,
      diseases: fields[4] as String,
      emergencyContactName: fields[5] as String,
      emergencyContactPhone: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonalInfo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dob)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.bloodType)
      ..writeByte(4)
      ..write(obj.diseases)
      ..writeByte(5)
      ..write(obj.emergencyContactName)
      ..writeByte(6)
      ..write(obj.emergencyContactPhone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
