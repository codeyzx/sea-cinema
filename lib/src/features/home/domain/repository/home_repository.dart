import 'package:fpdart/fpdart.dart';
import 'package:seacinema/src/features/home/domain/entities/movies.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/client/failure.dart';
import '../../data/repository/home_repository_impl.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Movies>?>> getMovies();
  Future<Either<Failure, List<Movies>?>> getUnderAge();
  Future<Either<Failure, List<Movies>?>> getThisYear();
  Future<Either<Failure, List<Movies>?>> getLastYear();
}

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepositoryImpl(),
);
