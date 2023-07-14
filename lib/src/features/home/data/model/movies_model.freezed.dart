// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movies_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoviesModel _$MoviesModelFromJson(Map<String, dynamic> json) {
  return _MoviesModel.fromJson(json);
}

/// @nodoc
mixin _$MoviesModel {
  List<Movies>? get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoviesModelCopyWith<MoviesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoviesModelCopyWith<$Res> {
  factory $MoviesModelCopyWith(
          MoviesModel value, $Res Function(MoviesModel) then) =
      _$MoviesModelCopyWithImpl<$Res, MoviesModel>;
  @useResult
  $Res call({List<Movies>? results});
}

/// @nodoc
class _$MoviesModelCopyWithImpl<$Res, $Val extends MoviesModel>
    implements $MoviesModelCopyWith<$Res> {
  _$MoviesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = freezed,
  }) {
    return _then(_value.copyWith(
      results: freezed == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Movies>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MoviesModelCopyWith<$Res>
    implements $MoviesModelCopyWith<$Res> {
  factory _$$_MoviesModelCopyWith(
          _$_MoviesModel value, $Res Function(_$_MoviesModel) then) =
      __$$_MoviesModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Movies>? results});
}

/// @nodoc
class __$$_MoviesModelCopyWithImpl<$Res>
    extends _$MoviesModelCopyWithImpl<$Res, _$_MoviesModel>
    implements _$$_MoviesModelCopyWith<$Res> {
  __$$_MoviesModelCopyWithImpl(
      _$_MoviesModel _value, $Res Function(_$_MoviesModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = freezed,
  }) {
    return _then(_$_MoviesModel(
      results: freezed == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Movies>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoviesModel implements _MoviesModel {
  const _$_MoviesModel({final List<Movies>? results}) : _results = results;

  factory _$_MoviesModel.fromJson(Map<String, dynamic> json) =>
      _$$_MoviesModelFromJson(json);

  final List<Movies>? _results;
  @override
  List<Movies>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MoviesModel(results: $results)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MoviesModel &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MoviesModelCopyWith<_$_MoviesModel> get copyWith =>
      __$$_MoviesModelCopyWithImpl<_$_MoviesModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MoviesModelToJson(
      this,
    );
  }
}

abstract class _MoviesModel implements MoviesModel {
  const factory _MoviesModel({final List<Movies>? results}) = _$_MoviesModel;

  factory _MoviesModel.fromJson(Map<String, dynamic> json) =
      _$_MoviesModel.fromJson;

  @override
  List<Movies>? get results;
  @override
  @JsonKey(ignore: true)
  _$$_MoviesModelCopyWith<_$_MoviesModel> get copyWith =>
      throw _privateConstructorUsedError;
}
