import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seacinema/src/core/client/endpoints.dart';
import 'package:seacinema/src/features/home/domain/entities/movies.dart';
import 'package:seacinema/src/features/movie_detail/presentation/movie_watchlist.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_utils/ansyn_value_widget.dart';
import '../../../core/client/dio_client.dart';
import 'home_controller.dart';
import 'widgets/grid_movie_widget.dart';
import 'widgets/image_number_widget.dart';

final keywordsProvider = StateProvider<String?>((ref) => '');
final apiToken = dotenv.env['API_KEY'];

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = 'home-screen';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var selectedIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('What do you want to watch?'),
          actions: [
            IconButton(
              onPressed: () {
                context.pushNamed(WatchlistScreen.routeName);
              },
              icon: Icon(
                FontAwesomeIcons.bookmark,
                size: 16.0.sp,
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : AsyncValueWidget<List<Movies>?>(
                        value: ref.watch(moviesControllerProvider),
                        data: (movies) => ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 16.5.sp),
                          scrollDirection: Axis.horizontal,
                          itemCount: movies?.length,
                          itemBuilder: (context, index) {
                            return ImageNumberWidget<Movies>(
                              movie: movies?[index] as Movies,
                              movies: movies!,
                              number: (index + 1),
                              type: 'movies',
                            );
                          },
                        ),
                      ),
              ),
              Expanded(
                child: DefaultTabController(
                  initialIndex: 0,
                  length: 4,
                  child: SafeArea(
                    child: Scaffold(
                      appBar: TabBar(
                        isScrollable: true,
                        tabs: [
                          const Tab(text: 'Popular').animate().fadeIn(duration: 600.ms).then(delay: 200.ms).slide(),
                          const Tab(text: '<15 Years Old').animate().fadeIn(duration: 650.ms).then(delay: 250.ms).slide(),
                          const Tab(text: 'This Year').animate().fadeIn(duration: 650.ms).then(delay: 250.ms).slide(),
                          const Tab(text: 'Last Year').animate().fadeIn(duration: 650.ms).then(delay: 250.ms).slide(),
                        ],
                      ),
                      body: RefreshIndicator(
                        onRefresh: () async {
                          fetchData();
                        },
                        child: TabBarView(
                          children: [
                            if (isLoading)
                              const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            else
                              AsyncValueWidget<List<Movies>?>(
                                value: ref.watch(moviesControllerProvider),
                                data: (movies) {
                                  return GridMovieWidget<Movies>(
                                    listData: movies,
                                    type: "movies",
                                  );
                                },
                              ),
                            if (isLoading)
                              const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            else
                              AsyncValueWidget<List<Movies>?>(
                                value: ref.watch(underAgeMoviesControllerProvider),
                                data: (movies) {
                                  return GridMovieWidget<Movies>(
                                    listData: movies,
                                    type: "under",
                                  );
                                },
                              ),
                            if (isLoading)
                              const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            else
                              AsyncValueWidget<List<Movies>?>(
                                value: ref.watch(thisYearMoviesControllerProvider),
                                data: (movies) {
                                  return GridMovieWidget<Movies>(
                                    listData: movies,
                                    type: "thisYear",
                                  );
                                },
                              ),
                            if (isLoading)
                              const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            else
                              AsyncValueWidget<List<Movies>?>(
                                value: ref.watch(lastYearMoviesControllerProvider),
                                data: (movies) {
                                  return GridMovieWidget<Movies>(
                                    listData: movies,
                                    type: "lastYear",
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    var respMovies = await DioClient().apiCall(
      url: Endpoints.movies,
      requestType: RequestType.get,
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
    for (var movie in respMovies.data) {
      movies.add(movie);
    }

    var moviesSorted = updateDuplicateIds(movies);

    List<dynamic> listMovies = moviesSorted;

    List<dynamic> listUnder = listMovies.where((e) => e['age_rating'] < 15).toList();

    List<dynamic> listThisYear =
        listMovies.where((e) => e['release_date'].toString().contains((DateTime.now().year).toString())).toList();

    List<dynamic> listLastYear =
        listMovies.where((e) => e['release_date'].toString().contains((DateTime.now().year - 1).toString())).toList();

    listMovies.map((e) {
      ref.read(homeController.notifier).add('movies', e['id']);
      return Movies.fromJson(e);
    }).toList();

    listUnder.map((e) {
      ref.read(homeController.notifier).add('under', e['id']);
      return Movies.fromJson(e);
    }).toList();

    listThisYear.map((e) {
      ref.read(homeController.notifier).add('thisYear', e['id']);
      return Movies.fromJson(e);
    }).toList();

    listLastYear.map((e) {
      ref.read(homeController.notifier).add('lastYear', e['id']);
      return Movies.fromJson(e);
    }).toList();
  }
}
