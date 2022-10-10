// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class taskModelAdapter extends TypeAdapter<taskModel> {
  @override
  final int typeId = 0;

  @override
  taskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return taskModel(
      title: fields[0] as String?,
      note: fields[1] as String?,
      creationDate: fields[2] as DateTime?,
      done: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, taskModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.creationDate)
      ..writeByte(3)
      ..write(obj.done);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is taskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
