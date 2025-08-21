// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_storage_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoStorageClassItemAdapter extends TypeAdapter<VideoStorageClassItem> {
  @override
  final int typeId = 1;

  @override
  VideoStorageClassItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoStorageClassItem(
      isActive: fields[0] as bool,
      date: fields[1] as String,
      time: fields[2] as String,
      timeElapsed: fields[3] as String,
      score: fields[4] as String,
      recordedVideoPaths: (fields[5] as List?)?.cast<String?>(),
    );
  }

  @override
  void write(BinaryWriter writer, VideoStorageClassItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.isActive)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.timeElapsed)
      ..writeByte(4)
      ..write(obj.score)
      ..writeByte(5)
      ..write(obj.recordedVideoPaths);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoStorageClassItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
