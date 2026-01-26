// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteDataModelAdapter extends TypeAdapter<NoteDataModel> {
  @override
  final int typeId = 0;

  @override
  NoteDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteDataModel(
      id: fields[0] as int,
      starred: fields[6] as bool,
      title: fields[1] as String,
      content: fields[2] as String,
      createdAt: fields[3] as String,
      updatedAt: fields[4] as String,
      colorHex: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteDataModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.starred)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.colorHex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
