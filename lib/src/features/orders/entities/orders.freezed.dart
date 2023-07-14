// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orders.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Orders _$OrdersFromJson(Map<String, dynamic> json) {
  return _Orders.fromJson(json);
}

/// @nodoc
mixin _$Orders {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'uid')
  String? get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'movie')
  Map<String, dynamic>? get movie => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'seat')
  List<String>? get seat => throw _privateConstructorUsedError;
  @JsonKey(name: 'totalPayment')
  int? get totalPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'statusPayment')
  bool? get statusPayment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrdersCopyWith<Orders> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrdersCopyWith<$Res> {
  factory $OrdersCopyWith(Orders value, $Res Function(Orders) then) =
      _$OrdersCopyWithImpl<$Res, Orders>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'uid') String? uid,
      @JsonKey(name: 'movie') Map<String, dynamic>? movie,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'seat') List<String>? seat,
      @JsonKey(name: 'totalPayment') int? totalPayment,
      @JsonKey(name: 'statusPayment') bool? statusPayment});
}

/// @nodoc
class _$OrdersCopyWithImpl<$Res, $Val extends Orders>
    implements $OrdersCopyWith<$Res> {
  _$OrdersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? movie = freezed,
    Object? createdAt = freezed,
    Object? seat = freezed,
    Object? totalPayment = freezed,
    Object? statusPayment = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      movie: freezed == movie
          ? _value.movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      seat: freezed == seat
          ? _value.seat
          : seat // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      totalPayment: freezed == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as int?,
      statusPayment: freezed == statusPayment
          ? _value.statusPayment
          : statusPayment // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrdersCopyWith<$Res> implements $OrdersCopyWith<$Res> {
  factory _$$_OrdersCopyWith(_$_Orders value, $Res Function(_$_Orders) then) =
      __$$_OrdersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'uid') String? uid,
      @JsonKey(name: 'movie') Map<String, dynamic>? movie,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'seat') List<String>? seat,
      @JsonKey(name: 'totalPayment') int? totalPayment,
      @JsonKey(name: 'statusPayment') bool? statusPayment});
}

/// @nodoc
class __$$_OrdersCopyWithImpl<$Res>
    extends _$OrdersCopyWithImpl<$Res, _$_Orders>
    implements _$$_OrdersCopyWith<$Res> {
  __$$_OrdersCopyWithImpl(_$_Orders _value, $Res Function(_$_Orders) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? movie = freezed,
    Object? createdAt = freezed,
    Object? seat = freezed,
    Object? totalPayment = freezed,
    Object? statusPayment = freezed,
  }) {
    return _then(_$_Orders(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      movie: freezed == movie
          ? _value._movie
          : movie // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      seat: freezed == seat
          ? _value._seat
          : seat // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      totalPayment: freezed == totalPayment
          ? _value.totalPayment
          : totalPayment // ignore: cast_nullable_to_non_nullable
              as int?,
      statusPayment: freezed == statusPayment
          ? _value.statusPayment
          : statusPayment // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Orders implements _Orders {
  const _$_Orders(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'uid') this.uid,
      @JsonKey(name: 'movie') final Map<String, dynamic>? movie,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'seat') final List<String>? seat,
      @JsonKey(name: 'totalPayment') this.totalPayment,
      @JsonKey(name: 'statusPayment') this.statusPayment})
      : _movie = movie,
        _seat = seat;

  factory _$_Orders.fromJson(Map<String, dynamic> json) =>
      _$$_OrdersFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'uid')
  final String? uid;
  final Map<String, dynamic>? _movie;
  @override
  @JsonKey(name: 'movie')
  Map<String, dynamic>? get movie {
    final value = _movie;
    if (value == null) return null;
    if (_movie is EqualUnmodifiableMapView) return _movie;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  final List<String>? _seat;
  @override
  @JsonKey(name: 'seat')
  List<String>? get seat {
    final value = _seat;
    if (value == null) return null;
    if (_seat is EqualUnmodifiableListView) return _seat;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'totalPayment')
  final int? totalPayment;
  @override
  @JsonKey(name: 'statusPayment')
  final bool? statusPayment;

  @override
  String toString() {
    return 'Orders(id: $id, uid: $uid, movie: $movie, createdAt: $createdAt, seat: $seat, totalPayment: $totalPayment, statusPayment: $statusPayment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Orders &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            const DeepCollectionEquality().equals(other._movie, _movie) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._seat, _seat) &&
            (identical(other.totalPayment, totalPayment) ||
                other.totalPayment == totalPayment) &&
            (identical(other.statusPayment, statusPayment) ||
                other.statusPayment == statusPayment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      uid,
      const DeepCollectionEquality().hash(_movie),
      createdAt,
      const DeepCollectionEquality().hash(_seat),
      totalPayment,
      statusPayment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrdersCopyWith<_$_Orders> get copyWith =>
      __$$_OrdersCopyWithImpl<_$_Orders>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrdersToJson(
      this,
    );
  }
}

abstract class _Orders implements Orders {
  const factory _Orders(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'uid') final String? uid,
      @JsonKey(name: 'movie') final Map<String, dynamic>? movie,
      @JsonKey(name: 'createdAt') final String? createdAt,
      @JsonKey(name: 'seat') final List<String>? seat,
      @JsonKey(name: 'totalPayment') final int? totalPayment,
      @JsonKey(name: 'statusPayment') final bool? statusPayment}) = _$_Orders;

  factory _Orders.fromJson(Map<String, dynamic> json) = _$_Orders.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'uid')
  String? get uid;
  @override
  @JsonKey(name: 'movie')
  Map<String, dynamic>? get movie;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'seat')
  List<String>? get seat;
  @override
  @JsonKey(name: 'totalPayment')
  int? get totalPayment;
  @override
  @JsonKey(name: 'statusPayment')
  bool? get statusPayment;
  @override
  @JsonKey(ignore: true)
  _$$_OrdersCopyWith<_$_Orders> get copyWith =>
      throw _privateConstructorUsedError;
}
