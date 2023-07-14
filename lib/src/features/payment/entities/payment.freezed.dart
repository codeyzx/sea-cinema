// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return _Payment.fromJson(json);
}

/// @nodoc
mixin _$Payment {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoiceId')
  String? get invoiceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'userId')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  String? get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalPayment')
  int? get totalPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'methodPayment')
  String? get methodPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  bool? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'statusPayment')
  String? get statusPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'tokenPayment')
  String? get tokenPayment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentCopyWith<Payment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCopyWith<$Res> {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) then) =
      _$PaymentCopyWithImpl<$Res, Payment>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'invoiceId') String? invoiceId,
      @JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'items') String? items,
      @JsonKey(name: 'totalPayment') int? totalPayment,
      @JsonKey(name: 'methodPayment') String? methodPayment,
      @JsonKey(name: 'status') bool? status,
      @JsonKey(name: 'statusPayment') String? statusPayment,
      @JsonKey(name: 'tokenPayment') String? tokenPayment});
}

/// @nodoc
class _$PaymentCopyWithImpl<$Res, $Val extends Payment>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? invoiceId = freezed,
    Object? userId = freezed,
    Object? createdAt = freezed,
    Object? items = freezed,
    Object? totalPayment = freezed,
    Object? methodPayment = freezed,
    Object? status = freezed,
    Object? statusPayment = freezed,
    Object? tokenPayment = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceId: freezed == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPayment: freezed == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as int?,
      methodPayment: freezed == methodPayment
          ? _value.methodPayment
          : methodPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      statusPayment: freezed == statusPayment
          ? _value.statusPayment
          : statusPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenPayment: freezed == tokenPayment
          ? _value.tokenPayment
          : tokenPayment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$$_PaymentCopyWith(
          _$_Payment value, $Res Function(_$_Payment) then) =
      __$$_PaymentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'invoiceId') String? invoiceId,
      @JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'items') String? items,
      @JsonKey(name: 'totalPayment') int? totalPayment,
      @JsonKey(name: 'methodPayment') String? methodPayment,
      @JsonKey(name: 'status') bool? status,
      @JsonKey(name: 'statusPayment') String? statusPayment,
      @JsonKey(name: 'tokenPayment') String? tokenPayment});
}

/// @nodoc
class __$$_PaymentCopyWithImpl<$Res>
    extends _$PaymentCopyWithImpl<$Res, _$_Payment>
    implements _$$_PaymentCopyWith<$Res> {
  __$$_PaymentCopyWithImpl(_$_Payment _value, $Res Function(_$_Payment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? invoiceId = freezed,
    Object? userId = freezed,
    Object? createdAt = freezed,
    Object? items = freezed,
    Object? totalPayment = freezed,
    Object? methodPayment = freezed,
    Object? status = freezed,
    Object? statusPayment = freezed,
    Object? tokenPayment = freezed,
  }) {
    return _then(_$_Payment(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceId: freezed == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPayment: freezed == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as int?,
      methodPayment: freezed == methodPayment
          ? _value.methodPayment
          : methodPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      statusPayment: freezed == statusPayment
          ? _value.statusPayment
          : statusPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenPayment: freezed == tokenPayment
          ? _value.tokenPayment
          : tokenPayment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Payment implements _Payment {
  const _$_Payment(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'invoiceId') this.invoiceId,
      @JsonKey(name: 'userId') this.userId,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'items') this.items,
      @JsonKey(name: 'totalPayment') this.totalPayment,
      @JsonKey(name: 'methodPayment') this.methodPayment,
      @JsonKey(name: 'status') this.status,
      @JsonKey(name: 'statusPayment') this.statusPayment,
      @JsonKey(name: 'tokenPayment') this.tokenPayment});

  factory _$_Payment.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'invoiceId')
  final String? invoiceId;
  @override
  @JsonKey(name: 'userId')
  final String? userId;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  @JsonKey(name: 'items')
  final String? items;
  @override
  @JsonKey(name: 'totalPayment')
  final int? totalPayment;
  @override
  @JsonKey(name: 'methodPayment')
  final String? methodPayment;
  @override
  @JsonKey(name: 'status')
  final bool? status;
  @override
  @JsonKey(name: 'statusPayment')
  final String? statusPayment;
  @override
  @JsonKey(name: 'tokenPayment')
  final String? tokenPayment;

  @override
  String toString() {
    return 'Payment(id: $id, invoiceId: $invoiceId, userId: $userId, createdAt: $createdAt, items: $items, totalPayment: $totalPayment, methodPayment: $methodPayment, status: $status, statusPayment: $statusPayment, tokenPayment: $tokenPayment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Payment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.items, items) || other.items == items) &&
            (identical(other.totalPayment, totalPayment) ||
                other.totalPayment == totalPayment) &&
            (identical(other.methodPayment, methodPayment) ||
                other.methodPayment == methodPayment) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.statusPayment, statusPayment) ||
                other.statusPayment == statusPayment) &&
            (identical(other.tokenPayment, tokenPayment) ||
                other.tokenPayment == tokenPayment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, invoiceId, userId, createdAt,
      items, totalPayment, methodPayment, status, statusPayment, tokenPayment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentCopyWith<_$_Payment> get copyWith =>
      __$$_PaymentCopyWithImpl<_$_Payment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentToJson(
      this,
    );
  }
}

abstract class _Payment implements Payment {
  const factory _Payment(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'invoiceId') final String? invoiceId,
      @JsonKey(name: 'userId') final String? userId,
      @JsonKey(name: 'createdAt') final String? createdAt,
      @JsonKey(name: 'items') final String? items,
      @JsonKey(name: 'totalPayment') final int? totalPayment,
      @JsonKey(name: 'methodPayment') final String? methodPayment,
      @JsonKey(name: 'status') final bool? status,
      @JsonKey(name: 'statusPayment') final String? statusPayment,
      @JsonKey(name: 'tokenPayment') final String? tokenPayment}) = _$_Payment;

  factory _Payment.fromJson(Map<String, dynamic> json) = _$_Payment.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'invoiceId')
  String? get invoiceId;
  @override
  @JsonKey(name: 'userId')
  String? get userId;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'items')
  String? get items;
  @override
  @JsonKey(name: 'totalPayment')
  int? get totalPayment;
  @override
  @JsonKey(name: 'methodPayment')
  String? get methodPayment;
  @override
  @JsonKey(name: 'status')
  bool? get status;
  @override
  @JsonKey(name: 'statusPayment')
  String? get statusPayment;
  @override
  @JsonKey(name: 'tokenPayment')
  String? get tokenPayment;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentCopyWith<_$_Payment> get copyWith =>
      throw _privateConstructorUsedError;
}
