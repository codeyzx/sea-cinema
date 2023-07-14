// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names
part of 'movies_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoviesModel _$$_MoviesModelFromJson(Map<String, dynamic> json) => _$_MoviesModel(
      results: (json['results'] as List<dynamic>?)?.map((e) => Movies.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$$_MoviesModelToJson(_$_MoviesModel instance) => <String, dynamic>{
      'results': instance.results,
    };
