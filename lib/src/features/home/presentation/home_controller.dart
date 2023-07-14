import 'dart:async';

import 'package:seacinema/src/features/home/domain/entities/movies.dart';
import 'package:seacinema/src/features/home/domain/repository/home_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeController extends StateNotifier<List<Map<String, dynamic>?>> {
  HomeController() : super([]) {
    getData();
  }

  List<Map<String, dynamic>?> getData() {
    return state;
  }

  void add(String category, dynamic value) {
    var myState = [...state];
    var findIndex = myState.indexWhere(
      (element) => element!['category'] == category && element['value'] == value,
    );
    if (findIndex == -1) {
      myState.add({
        'category': category,
        'value': value,
      });
    }
    state = myState;
  }
}

final homeController = StateNotifierProvider<HomeController, List<Map<String, dynamic>?>>(
  (ref) => HomeController(),
);

final listOfMovieProvider = StateProvider<List<dynamic>?>(
  (ref) {
    return [];
  },
);

class FetchMovieController extends StateNotifier<AsyncValue<List<dynamic>?>> {
  FetchMovieController() : super(const AsyncValue.loading());
}

class MoviesController extends StateNotifier<AsyncValue<List<Movies>?>> {
  final HomeRepository repository;
  MoviesController({
    required this.repository,
  }) : super(const AsyncValue.loading()) {
    getMovies();
  }

  Future<void> getMovies() async {
    state = const AsyncValue.loading();
    final resp = await repository.getMovies();
    state = await resp.fold(
      (l) => AsyncValue.error(l, StackTrace.current),
      (r) => AsyncValue.data(r),
    );
  }
}

final moviesControllerProvider = StateNotifierProvider<MoviesController, AsyncValue<List<Movies>?>>(
  (ref) => MoviesController(
    repository: ref.watch(homeRepositoryProvider),
  ),
);

class UnderAgeMoviesController extends StateNotifier<AsyncValue<List<Movies>?>> {
  final HomeRepository repository;
  UnderAgeMoviesController({
    required this.repository,
  }) : super(const AsyncValue.loading()) {
    getUnderAgeMovies();
  }

  Future<void> getUnderAgeMovies() async {
    state = const AsyncValue.loading();
    final resp = await repository.getUnderAge();
    state = await resp.fold(
      (l) => AsyncValue.error(l, StackTrace.current),
      (r) => AsyncValue.data(r),
    );
  }
}

final underAgeMoviesControllerProvider = StateNotifierProvider<UnderAgeMoviesController, AsyncValue<List<Movies>?>>(
  (ref) => UnderAgeMoviesController(
    repository: ref.watch(homeRepositoryProvider),
  ),
);

class ThisYearMoviesController extends StateNotifier<AsyncValue<List<Movies>?>> {
  final HomeRepository repository;
  ThisYearMoviesController({
    required this.repository,
  }) : super(const AsyncValue.loading()) {
    getThisYearMovies();
  }

  Future<void> getThisYearMovies() async {
    state = const AsyncValue.loading();
    final resp = await repository.getThisYear();
    state = await resp.fold(
      (l) => AsyncValue.error(l, StackTrace.current),
      (r) => AsyncValue.data(r),
    );
  }
}

final thisYearMoviesControllerProvider = StateNotifierProvider<ThisYearMoviesController, AsyncValue<List<Movies>?>>(
  (ref) => ThisYearMoviesController(
    repository: ref.watch(homeRepositoryProvider),
  ),
);

class LastYearMoviesController extends StateNotifier<AsyncValue<List<Movies>?>> {
  final HomeRepository repository;
  LastYearMoviesController({
    required this.repository,
  }) : super(const AsyncValue.loading()) {
    getLastYearMovies();
  }

  Future<void> getLastYearMovies() async {
    state = const AsyncValue.loading();
    final resp = await repository.getLastYear();
    state = await resp.fold(
      (l) => AsyncValue.error(l, StackTrace.current),
      (r) => AsyncValue.data(r),
    );
  }
}

final lastYearMoviesControllerProvider = StateNotifierProvider<LastYearMoviesController, AsyncValue<List<Movies>?>>(
  (ref) => LastYearMoviesController(
    repository: ref.watch(homeRepositoryProvider),
  ),
);
