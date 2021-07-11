// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'used-word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsedWordAdapter extends TypeAdapter<UsedWord> {
  @override
  final int typeId = 0;

  @override
  UsedWord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsedWord(
      fields[5] as DateTime,
      fields[0] as String,
      fields[3] as String,
      fields[4] as String,
      fields[2] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UsedWord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.word)
      ..writeByte(2)
      ..write(obj.translation)
      ..writeByte(3)
      ..write(obj.sentenceItisUsedIn)
      ..writeByte(4)
      ..write(obj.synonims)
      ..writeByte(5)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsedWordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
