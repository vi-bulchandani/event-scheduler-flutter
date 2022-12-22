// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyEventAdapter extends TypeAdapter<MyEvent> {
  @override
  final int typeId = 1;

  @override
  MyEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyEvent(
      fields[1] as String,
      fields[0] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, MyEvent obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.desc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
