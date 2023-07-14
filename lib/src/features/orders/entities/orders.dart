// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'orders.freezed.dart';
part 'orders.g.dart';

@freezed
abstract class Orders with _$Orders {
  const factory Orders({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'uid') String? uid,
    @JsonKey(name: 'movie') Map<String, dynamic>? movie,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'seat') List<String>? seat,
    @JsonKey(name: 'totalPayment') int? totalPayment,
    @JsonKey(name: 'statusPayment') bool? statusPayment,
  }) = _Orders;

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);
}
