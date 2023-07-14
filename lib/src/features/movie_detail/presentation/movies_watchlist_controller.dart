import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seacinema/src/features/home/domain/entities/movies.dart';

class MoviesWatchlistController extends StateNotifier<List<Movies>?> {
  MoviesWatchlistController() : super([]);

  bool isWishlist(Movies movie) {
    var myState = [...?state];
    return myState.contains(movie);
  }

  void addToWatchlist(Movies trending) {
    var myState = [...?state];
    var index = myState.indexWhere((element) => element.id == trending.id);
    if (index == -1) {
      myState.add(trending);
    }
    state = myState;
  }

  void removeFromWatchlist(Movies trending) {
    var myState = [...?state];
    var index = myState.indexWhere((element) => element.id == trending.id);
    if (index != -1) {
      myState.removeAt(index);
    }
    state = myState;
  }
}

final watchliztControllerProvider = StateNotifierProvider<MoviesWatchlistController, List<Movies>?>(
  (ref) => MoviesWatchlistController(),
);
