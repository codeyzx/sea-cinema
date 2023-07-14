// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Payment _$$_PaymentFromJson(Map<String, dynamic> json) => _$_Payment(
      id: json['id'] as String?,
      invoiceId: json['invoiceId'] as String?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] as String?,
      items: json['items'] as String?,
      totalPayment: json['totalPayment'] as int?,
      methodPayment: json['methodPayment'] as String?,
      status: json['status'] as bool?,
      statusPayment: json['statusPayment'] as String?,
      tokenPayment: json['tokenPayment'] as String?,
    );

Map<String, dynamic> _$$_PaymentToJson(_$_Payment instance) => <String, dynamic>{
      'id': instance.id,
      'invoiceId': instance.invoiceId,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'items': instance.items,
      'totalPayment': instance.totalPayment,
      'methodPayment': instance.methodPayment,
      'status': instance.status,
      'statusPayment': instance.statusPayment,
      'tokenPayment': instance.tokenPayment,
    };
