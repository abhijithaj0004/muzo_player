// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topbeats_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopBeatsModelAdapter extends TypeAdapter<TopBeatsModel> {
  @override
  final int typeId = 3;

  @override
  TopBeatsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopBeatsModel(
      id: fields[0] as int,
      count: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TopBeatsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopBeatsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
