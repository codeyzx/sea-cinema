// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'movies.freezed.dart';
part 'movies.g.dart';

@freezed
abstract class Movies with _$Movies {
  const factory Movies({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'release_date') dynamic releaseDate,
    @JsonKey(name: 'poster_url') String? posterUrl,
    @JsonKey(name: 'age_rating') int? ageRating,
    @JsonKey(name: 'ticket_price') int? ticketPrice,
  }) = _Movies;

  factory Movies.fromJson(Map<String, dynamic> json) => _$MoviesFromJson(json);
}
