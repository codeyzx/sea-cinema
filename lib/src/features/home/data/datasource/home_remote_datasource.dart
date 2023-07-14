import 'package:seacinema/src/features/home/domain/entities/movies.dart';

import '../../../../core/client/dio_client.dart';
import '../../../../core/client/endpoints.dart';

abstract class HomeRemoteDataSource {
  Future<List<Movies>> getMovies();
  Future<List<Movies>> getUnderAge();
  Future<List<Movies>> getThisYear();
  Future<List<Movies>> getLastYear();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<Movies>> getMovies() async {
    final resp = await DioClient().apiCall(
      url: Endpoints.movies,
      requestType: RequestType.get,
      queryParameters: {},
    );

    List<Map<String, dynamic>> updateDuplicateIds(List<Map<String, dynamic>> listOfMaps) {
      List<int> duplicatedIds = [];
      List<Map<String, dynamic>> updatedList = [];

      for (var map in listOfMaps) {
        int id = map['id'];
        if (duplicatedIds.contains(id)) {
          int newId = id;
          while (duplicatedIds.contains(newId)) {
            newId++;
          }

          duplicatedIds.add(newId);
          map['id'] = newId;
        } else {
          duplicatedIds.add(id);
        }
        updatedList.add(map);
      }

      return updatedList;
    }

    List<Map<String, dynamic>> movies = [];
    for (var movie in resp.data) {
      movies.add(movie);
    }

    var moviesSorted = updateDuplicateIds(movies);

    List<Movies> moviesList = [];
    for (var item in moviesSorted) {
      moviesList.add(Movies.fromJson(item));
    }
    return moviesList;
  }

  @override
  Future<List<Movies>> getUnderAge() async {
    final List<Movies> movies = await getMovies();
    List<Movies> underAge = [];
    for (var movie in movies) {
      if (movie.ageRating! < 15) {
        underAge.add(movie);
      }
    }
    return underAge;
  }

  @override
  Future<List<Movies>> getThisYear() async {
    final List<Movies> movies = await getMovies();
    List<Movies> thisYear = [];
    for (var movie in movies) {
      if (movie.releaseDate.toString().contains(DateTime.now().year.toString())) {
        thisYear.add(movie);
      }
    }
    return thisYear;
  }

  @override
  Future<List<Movies>> getLastYear() async {
    final List<Movies> movies = await getMovies();
    List<Movies> lastYear = [];
    for (var movie in movies) {
      if (movie.releaseDate.toString().contains((DateTime.now().year - 1).toString())) {
        lastYear.add(movie);
      }
    }
    return lastYear;
  }
}
