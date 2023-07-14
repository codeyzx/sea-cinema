// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'orders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Orders _$$_OrdersFromJson(Map<String, dynamic> json) => _$_Orders(
      id: json['id'] as String?,
      uid: json['uid'] as String?,
      movie: json['movie'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] as String?,
      seat: (json['seat'] as List<dynamic>?)?.map((e) => e as String).toList(),
      totalPayment: json['totalPayment'] as int?,
      statusPayment: json['statusPayment'] as bool?,
    );

Map<String, dynamic> _$$_OrdersToJson(_$_Orders instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'movie': instance.movie,
      'createdAt': instance.createdAt,
      'seat': instance.seat,
      'totalPayment': instance.totalPayment,
      'statusPayment': instance.statusPayment,
    };
