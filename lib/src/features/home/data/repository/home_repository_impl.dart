import 'package:fpdart/fpdart.dart';
import 'package:seacinema/src/features/home/domain/entities/movies.dart';

import '../../../../core/client/dio_client.dart';
import '../../../../core/client/failure.dart';
import '../../domain/repository/home_repository.dart';
import '../datasource/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final remoteDataSource = HomeRemoteDataSourceImpl();

  @override
  Future<Either<Failure, List<Movies>?>> getMovies() async {
    final resp = await remoteProcess(
      remoteDataSource.getMovies(),
    );
    return resp.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, List<Movies>?>> getUnderAge() async {
    final resp = await remoteProcess(
      remoteDataSource.getUnderAge(),
    );
    return resp.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, List<Movies>?>> getThisYear() async {
    final resp = await remoteProcess(
      remoteDataSource.getThisYear(),
    );
    return resp.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, List<Movies>?>> getLastYear() async {
    final resp = await remoteProcess(
      remoteDataSource.getLastYear(),
    );
    return resp.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
