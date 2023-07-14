// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
abstract class Payment with _$Payment {
  const factory Payment({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'invoiceId') String? invoiceId,
    @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'items') String? items,
    @JsonKey(name: 'totalPayment') int? totalPayment,
    @JsonKey(name: 'methodPayment') String? methodPayment,
    @JsonKey(name: 'status') bool? status,
    @JsonKey(name: 'statusPayment') String? statusPayment,
    @JsonKey(name: 'tokenPayment') String? tokenPayment,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
}
