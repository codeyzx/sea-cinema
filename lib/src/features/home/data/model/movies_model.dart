import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seacinema/src/features/home/domain/entities/movies.dart';

part 'movies_model.freezed.dart';
part 'movies_model.g.dart';

@freezed
abstract class MoviesModel with _$MoviesModel {
  const factory MoviesModel({
    List<Movies>? results,
  }) = _MoviesModel;

  factory MoviesModel.fromJson(Map<String, dynamic> json) => _$MoviesModelFromJson(json);
}
