// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubscriptionAdapter extends TypeAdapter<Subscription> {
  @override
  final int typeId = 1;

  @override
  Subscription read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subscription.noEnum(
      brand: fields[0] as Brand,
      cost: fields[1] as double,
      description: fields[2] as String?,
      subscriptionId: fields[3] as String,
      renewsEvery: fields[4],
      category: fields[5] as String?,
      sharedWith: fields[6] as int?,
      startedOn: fields[7] as DateTime,
      notificationOn: fields[8],
      payments: fields[9],
      remaningDays: fields[10],
    );
  }

  @override
  void write(BinaryWriter writer, Subscription obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.brand)
      ..writeByte(1)
      ..write(obj.cost)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.subscriptionId)
      ..writeByte(4)
      ..write(obj.renewsEveryValue)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.sharedWith)
      ..writeByte(7)
      ..write(obj.startedOn)
      ..writeByte(8)
      ..write(obj.notificationOnValue)
      ..writeByte(9)
      ..write(obj.payments)
      ..writeByte(10)
      ..write(obj.remaningDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
