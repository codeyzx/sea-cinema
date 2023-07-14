// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movies.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Movies _$MoviesFromJson(Map<String, dynamic> json) {
  return _Movies.fromJson(json);
}

/// @nodoc
mixin _$Movies {
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'release_date')
  dynamic get releaseDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'poster_url')
  String? get posterUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'age_rating')
  int? get ageRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'ticket_price')
  int? get ticketPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoviesCopyWith<Movies> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoviesCopyWith<$Res> {
  factory $MoviesCopyWith(Movies value, $Res Function(Movies) then) =
      _$MoviesCopyWithImpl<$Res, Movies>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'release_date') dynamic releaseDate,
      @JsonKey(name: 'poster_url') String? posterUrl,
      @JsonKey(name: 'age_rating') int? ageRating,
      @JsonKey(name: 'ticket_price') int? ticketPrice});
}

/// @nodoc
class _$MoviesCopyWithImpl<$Res, $Val extends Movies>
    implements $MoviesCopyWith<$Res> {
  _$MoviesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? releaseDate = freezed,
    Object? posterUrl = freezed,
    Object? ageRating = freezed,
    Object? ticketPrice = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      posterUrl: freezed == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      ageRating: freezed == ageRating
          ? _value.ageRating
          : ageRating // ignore: cast_nullable_to_non_nullable
              as int?,
      ticketPrice: freezed == ticketPrice
          ? _value.ticketPrice
          : ticketPrice // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MoviesCopyWith<$Res> implements $MoviesCopyWith<$Res> {
  factory _$$_MoviesCopyWith(_$_Movies value, $Res Function(_$_Movies) then) =
      __$$_MoviesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'release_date') dynamic releaseDate,
      @JsonKey(name: 'poster_url') String? posterUrl,
      @JsonKey(name: 'age_rating') int? ageRating,
      @JsonKey(name: 'ticket_price') int? ticketPrice});
}

/// @nodoc
class __$$_MoviesCopyWithImpl<$Res>
    extends _$MoviesCopyWithImpl<$Res, _$_Movies>
    implements _$$_MoviesCopyWith<$Res> {
  __$$_MoviesCopyWithImpl(_$_Movies _value, $Res Function(_$_Movies) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? releaseDate = freezed,
    Object? posterUrl = freezed,
    Object? ageRating = freezed,
    Object? ticketPrice = freezed,
  }) {
    return _then(_$_Movies(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      posterUrl: freezed == posterUrl
          ? _value.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      ageRating: freezed == ageRating
          ? _value.ageRating
          : ageRating // ignore: cast_nullable_to_non_nullable
              as int?,
      ticketPrice: freezed == ticketPrice
          ? _value.ticketPrice
          : ticketPrice // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Movies implements _Movies {
  const _$_Movies(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'title') this.title,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'release_date') this.releaseDate,
      @JsonKey(name: 'poster_url') this.posterUrl,
      @JsonKey(name: 'age_rating') this.ageRating,
      @JsonKey(name: 'ticket_price') this.ticketPrice});

  factory _$_Movies.fromJson(Map<String, dynamic> json) =>
      _$$_MoviesFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'release_date')
  final dynamic releaseDate;
  @override
  @JsonKey(name: 'poster_url')
  final String? posterUrl;
  @override
  @JsonKey(name: 'age_rating')
  final int? ageRating;
  @override
  @JsonKey(name: 'ticket_price')
  final int? ticketPrice;

  @override
  String toString() {
    return 'Movies(id: $id, title: $title, description: $description, releaseDate: $releaseDate, posterUrl: $posterUrl, ageRating: $ageRating, ticketPrice: $ticketPrice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Movies &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other.releaseDate, releaseDate) &&
            (identical(other.posterUrl, posterUrl) ||
                other.posterUrl == posterUrl) &&
            (identical(other.ageRating, ageRating) ||
                other.ageRating == ageRating) &&
            (identical(other.ticketPrice, ticketPrice) ||
                other.ticketPrice == ticketPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(releaseDate),
      posterUrl,
      ageRating,
      ticketPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MoviesCopyWith<_$_Movies> get copyWith =>
      __$$_MoviesCopyWithImpl<_$_Movies>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MoviesToJson(
      this,
    );
  }
}

abstract class _Movies implements Movies {
  const factory _Movies(
      {@JsonKey(name: 'id') final int? id,
      @JsonKey(name: 'title') final String? title,
      @JsonKey(name: 'description') final String? description,
      @JsonKey(name: 'release_date') final dynamic releaseDate,
      @JsonKey(name: 'poster_url') final String? posterUrl,
      @JsonKey(name: 'age_rating') final int? ageRating,
      @JsonKey(name: 'ticket_price') final int? ticketPrice}) = _$_Movies;

  factory _Movies.fromJson(Map<String, dynamic> json) = _$_Movies.fromJson;

  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'release_date')
  dynamic get releaseDate;
  @override
  @JsonKey(name: 'poster_url')
  String? get posterUrl;
  @override
  @JsonKey(name: 'age_rating')
  int? get ageRating;
  @override
  @JsonKey(name: 'ticket_price')
  int? get ticketPrice;
  @override
  @JsonKey(ignore: true)
  _$$_MoviesCopyWith<_$_Movies> get copyWith =>
      throw _privateConstructorUsedError;
}
