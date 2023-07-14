// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Movies _$$_MoviesFromJson(Map<String, dynamic> json) => _$_Movies(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      releaseDate: json['release_date'],
      posterUrl: json['poster_url'] as String?,
      ageRating: json['age_rating'] as int?,
      ticketPrice: json['ticket_price'] as int?,
    );

Map<String, dynamic> _$$_MoviesToJson(_$_Movies instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'release_date': instance.releaseDate,
      'poster_url': instance.posterUrl,
      'age_rating': instance.ageRating,
      'ticket_price': instance.ticketPrice,
    };
