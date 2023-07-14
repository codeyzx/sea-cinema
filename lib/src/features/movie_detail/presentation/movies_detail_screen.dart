import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickalert/quickalert.dart';
import 'package:seacinema/src/common_config/app_theme.dart';
import 'package:seacinema/src/core/client/dio_client.dart';
import 'package:seacinema/src/core/client/endpoints.dart';
import 'package:seacinema/src/features/auth/presentation/auth_controller.dart';
import 'package:seacinema/src/features/home/domain/entities/movies.dart';

import 'package:seacinema/src/features/home/presentation/home_controller.dart';
import 'package:seacinema/src/features/movie_detail/presentation/movies_watchlist_controller.dart';
import 'package:seacinema/src/features/movie_detail/presentation/widgets/about_movie.dart';
import 'package:seacinema/src/features/movie_detail/presentation/widgets/movie_status.dart';
import 'package:seacinema/src/features/movie_detail/presentation/widgets/reviews.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:seacinema/src/features/movie_detail/presentation/widgets/movie_item_widget.dart';

class MoviesDetailScreen extends StatefulHookConsumerWidget {
  final Map<String, dynamic>? idAndObject;

  const MoviesDetailScreen({
    Key? key,
    this.idAndObject,
  }) : super(key: key);
  static const routeName = 'movies-detail-screen';

  @override
  ConsumerState<MoviesDetailScreen> createState() => _MoviesDetailScreenState();
}

class _MoviesDetailScreenState extends ConsumerState<MoviesDetailScreen> {
  int? age;
  Movies detailMovie = const Movies();
  bool isLoading = false;
  bool isError = false;
  final List<PaletteColor> _colors = [];
  final int _currentIndex = 0;
  dynamic nextMovieId = 0;
  dynamic prevMovieId = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
    getUserAge();
  }

  void getUserAge() {
    String dateOfBirthString = ref.read(authControllerProvider).birth.toString();
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime dateOfBirth = dateFormat.parse(dateOfBirthString);
    DateTime now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month || (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    setState(() {
      this.age = age;
    });
  }

  @override
  Widget build(BuildContext context) {
    TabBar myTabBar = TabBar(
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(2.5.sp),
        color: _colors.isNotEmpty ? _colors[_currentIndex].color.withOpacity(.3) : Colors.black.withOpacity(0.5),
      ),
      tabs: const [
        Tab(child: Text('Reviews')),
        Tab(child: Text('About Movie')),
      ],
      indicatorColor: AppTheme.textColor,
      unselectedLabelColor: Colors.white,
      unselectedLabelStyle: TextStyle(fontSize: 11.0.sp),
      labelColor: Colors.white,
      labelStyle: TextStyle(fontSize: 10.0.sp),
    );

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Movie'),
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.chevronLeft),
            onPressed: () {
              context.goNamed(ref.watch(movieDetailAccessFromProvider));
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(watchliztControllerProvider.notifier).addToWatchlist(detailMovie);
                ref.read(homeController.notifier).add('watchlist', detailMovie.id);
                setState(() {});
              },
              icon: getStatusWitch(detailMovie),
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : widget.idAndObject!['type'] != 'watchlist'
                ? Swiper(
                    itemCount: getCountIndex(),
                    loop: true,
                    autoplay: false,
                    onIndexChanged: (value) {
                      if (value == 1) {
                        context.pushNamed(
                          MoviesDetailScreen.routeName,
                          extra: {
                            "id": nextMovieId,
                            "object": widget.idAndObject!['object'],
                            "type": widget.idAndObject!['type'],
                          },
                        );
                      } else {
                        if (prevMovieId != 0) {
                          context.pushNamed(
                            MoviesDetailScreen.routeName,
                            extra: {
                              "id": prevMovieId,
                              "object": widget.idAndObject!['object'],
                              "type": widget.idAndObject!['type'],
                            },
                          );
                        }
                      }
                    },
                    scale: .9,
                    curve: Curves.easeInOut,
                    itemBuilder: (context, index) {
                      if (isError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200.0.w,
                              child: Text(
                                'Sorry 🙏, The resource you requested could not be found. Movie with ID ${widget.idAndObject?['id']} not found',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.textBlueColor,
                              ),
                              onPressed: () {},
                              child: const Text('Swipe to Home'),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).size.height * .09.sp,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20.0.sp),
                                            bottomRight: Radius.circular(20.0.sp),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: _colors.isNotEmpty
                                                  ? _colors[_currentIndex].color.withOpacity(.3)
                                                  : Colors.black.withOpacity(0.5),
                                              spreadRadius: 5.5.sp,
                                              blurRadius: 5.0.sp,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                          color: AppTheme.secondaryColor,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20.0.sp),
                                            bottomRight: Radius.circular(20.0.sp),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/w780/${detailMovie.posterUrl?.split("w500/").last}",
                                            height: MediaQuery.of(context).size.height * .5.sp,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 100.0.sp,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.info,
                                              title: 'Only for 18+',
                                              text: 'This movie is only for 18+',
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(vertical: 15.0.sp, horizontal: 15.0.sp),
                                            width: 70.0.sp,
                                            height: 35.0.sp,
                                            decoration: BoxDecoration(
                                              color: AppTheme.primaryColor,
                                              borderRadius: BorderRadius.circular(10.0.sp),
                                              border: Border.all(color: Colors.orange),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                  right: 5.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text('${detailMovie.ageRating}+',
                                                        style: TextStyle(
                                                          fontSize: 20.0.sp,
                                                          color: Colors.orange,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    left: 0.0.sp,
                                    right: 0.0.sp,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 25.0.sp,
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 75.0.sp,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0.sp),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: _colors.isNotEmpty
                                                        ? _colors[_currentIndex].color.withOpacity(.5)
                                                        : Colors.white,
                                                    blurRadius: 10.0.sp,
                                                    spreadRadius: 5.0.sp,
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
                                                child: detailMovie.posterUrl != null
                                                    ? Image.network(
                                                        detailMovie.posterUrl.toString(),
                                                        fit: BoxFit.cover,
                                                        width: 90.sp,
                                                      )
                                                    : Image.asset(
                                                        'assets/icons/no-image.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            const SizedBox(width: 25),
                                            Flexible(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: Platform.isIOS ? 30.0.sp : 50.0.sp),
                                                  Text(
                                                    '${detailMovie.title}',
                                                    style: TextStyle(
                                                      fontSize: 22.0.sp,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.0.sp),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.6.sp,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MovieStatus(
                                        icon: FontAwesomeIcons.calendarWeek,
                                        text: detailMovie.releaseDate != ''
                                            ? DateFormat('dd MMM yyyy')
                                                .format(DateTime.parse(detailMovie.releaseDate.toString()))
                                                .toString()
                                            : '-',
                                      ),
                                      MovieStatus(
                                        icon: FontAwesomeIcons.ticket,
                                        text: NumberFormat.currency(
                                          locale: "id",
                                          symbol: "Rp",
                                          decimalDigits: 0,
                                        ).format(detailMovie.ticketPrice),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0.sp),
                            Expanded(
                              flex: 2,
                              child: DefaultTabController(
                                length: 2,
                                child: Scaffold(
                                  appBar: myTabBar,
                                  body: !isLoading
                                      ? TabBarView(
                                          children: [
                                            AboutMovie(
                                              age: age,
                                              movie: detailMovie,
                                              movieTitle: detailMovie.title,
                                              content: detailMovie.description ?? '-',
                                              color: _colors.isNotEmpty ? _colors[_currentIndex].color : Colors.white,
                                            ),
                                            Reviews(content: detailMovie.description ?? '-'),
                                          ],
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    })
                : Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .09.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15.0.sp), bottomRight: Radius.circular(15.0.sp)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: _colors.isNotEmpty
                                            ? _colors[_currentIndex].color.withOpacity(.3)
                                            : Colors.black.withOpacity(0.5),
                                        spreadRadius: 5.5.sp,
                                        blurRadius: 5.0.sp,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                    color: AppTheme.secondaryColor,
                                  ),
                                  child: Center(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://image.tmdb.org/t/p/w780/${detailMovie.posterUrl?.split("w500/").last}",
                                      height: MediaQuery.of(context).size.height * .5.sp,
                                      fit: BoxFit.fitHeight,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 100.0.sp,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.info,
                                        title: 'Only for 18+',
                                        text: 'This movie is only for 18+',
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 15.0.sp, horizontal: 15.0.sp),
                                      width: 70.0.sp,
                                      height: 35.0.sp,
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor,
                                        borderRadius: BorderRadius.circular(10.0.sp),
                                        border: Border.all(color: Colors.orange),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5.0,
                                            right: 5.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.do_not_touch_rounded,
                                                  color: Colors.red.withOpacity(0.8), size: 12.0.sp),
                                              Text('${detailMovie.ageRating}+',
                                                  style: TextStyle(
                                                    fontSize: 20.0.sp,
                                                    color: Colors.orange,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              left: 0.0.sp,
                              right: 0.0.sp,
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 25.0.sp,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 75.0.sp,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0.sp),
                                          boxShadow: [
                                            BoxShadow(
                                              color: _colors.isNotEmpty
                                                  ? _colors[_currentIndex].color.withOpacity(.5)
                                                  : Colors.white,
                                              blurRadius: 10.0.sp,
                                              spreadRadius: 5.0.sp,
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
                                          child: detailMovie.posterUrl != null
                                              ? Image.network(
                                                  detailMovie.posterUrl!,
                                                  fit: BoxFit.cover,
                                                  width: 90.sp,
                                                )
                                              : Image.asset(
                                                  'assets/icons/no-image.png',
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(width: 25),
                                      Flexible(
                                        child: Column(
                                          children: [
                                            SizedBox(height: Platform.isIOS ? 30.0.sp : 50.0.sp),
                                            Text(
                                              '${detailMovie.title}',
                                              style: TextStyle(
                                                fontSize: 22.0.sp,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0.sp),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6.sp,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MovieStatus(
                                  icon: FontAwesomeIcons.calendarWeek,
                                  text: detailMovie.releaseDate != ''
                                      ? DateFormat('dd MMM yyyy')
                                          .format(DateTime.parse(detailMovie.releaseDate.toString()))
                                          .toString()
                                      : '-',
                                ),
                                MovieStatus(
                                  icon: FontAwesomeIcons.ticket,
                                  text: NumberFormat.currency(
                                    locale: "id",
                                    symbol: "Rp",
                                    decimalDigits: 0,
                                  ).format(detailMovie.ticketPrice),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0.sp),
                      Expanded(
                        flex: 2,
                        child: DefaultTabController(
                          length: 2,
                          child: Scaffold(
                            appBar: myTabBar,
                            body: TabBarView(
                              children: [
                                AboutMovie(
                                  age: age,
                                  movie: detailMovie,
                                  movieTitle: detailMovie.title,
                                  content: detailMovie.description ?? '-',
                                  color: _colors.isNotEmpty ? _colors[_currentIndex].color.withOpacity(.5) : Colors.white,
                                ),
                                Reviews(content: detailMovie.description ?? '-'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  void fetchData() async {
    Logger().i('listOfIds: ${widget.idAndObject!['type']}');
    try {
      if (widget.idAndObject!['type'] != 'watchlist') {
        final listIdState = ref.read(homeController);
        final listOfIds = listIdState.where(
          (element) => element?['category'] == widget.idAndObject?['type'],
        );
        Logger().i('listOfIds: $listOfIds');
        var myData = [...listOfIds];
        var findIndex = myData.indexWhere(
          (element) {
            return element!['value'] == widget.idAndObject!['id'] && element['category'] == widget.idAndObject!['type'];
          },
        );
        Map? nextMovieIndex = {};
        Map? prevMovieIndex = {};
        if (findIndex != -1 && myData.length > (findIndex + 1)) {
          nextMovieIndex = myData[findIndex + 1];
          if (findIndex != 0) {
            Logger().i('prevMovieIndex true: $findIndex');
            prevMovieIndex = myData[findIndex - 1];
          } else {
            Logger().i('prevMovieIndex false: $findIndex');
            prevMovieIndex = myData[findIndex];
          }
          Logger().i('true $nextMovieIndex, $prevMovieIndex');
        } else {
          nextMovieIndex = myData[findIndex];
          prevMovieIndex = myData[findIndex - 1];

          Logger().i('false $nextMovieIndex, $prevMovieIndex');
        }

        setState(() {
          nextMovieId = nextMovieIndex?['value'];
          prevMovieId = prevMovieIndex?['value'];
          isLoading = true;
        });

        List<Movies> movies = widget.idAndObject?['object'] as List<Movies>;

        Movies movieDetailResponse = movies.firstWhere((element) => element.id == widget.idAndObject?['id']);

        var poster = movieDetailResponse.posterUrl;
        final generator = await PaletteGenerator.fromImageProvider(NetworkImage(poster.toString()));

        _colors.add(
          generator.darkVibrantColor ?? generator.lightVibrantColor ?? PaletteColor(Colors.teal, 2),
        );

        setState(() {
          detailMovie = movieDetailResponse;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = true;
        });
        var respMovies = await DioClient().apiCall(
          url: Endpoints.movies,
          requestType: RequestType.get,
        );

        var respMoviesBody = respMovies.data;

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

        List<Map<String, dynamic>> temp = [];
        for (var movie in respMoviesBody) {
          temp.add(movie);
        }

        var moviesSorted = updateDuplicateIds(temp);

        List<Movies> movies = moviesSorted.map((e) => Movies.fromJson(e)).toList();

        Movies movieDetailResponse = movies.firstWhere((element) => element.id == widget.idAndObject?['id']);

        var poster = movieDetailResponse.posterUrl;
        final generator = await PaletteGenerator.fromImageProvider(NetworkImage(poster.toString()));
        _colors.add(
          generator.darkVibrantColor ?? generator.lightVibrantColor ?? PaletteColor(Colors.teal, 2),
        );

        setState(() {
          detailMovie = movieDetailResponse;
          isLoading = false;
        });
      }
    } on DioException catch (e) {
      Logger().e('On Dio Exception: $e');
      setState(() {
        isError = true;
        isLoading = false;
      });
    } catch (e) {
      Logger().e('On Catch: $e');
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  Widget getStatusWitch(Movies detailMovie) {
    var status = ref.read(watchliztControllerProvider.notifier).isWishlist(detailMovie);
    return status
        ? Icon(
            Icons.bookmark_added,
            color: Colors.orange,
            size: 24.0.sp,
          )
        : Icon(
            Icons.bookmark_border,
            color: Colors.orange,
            size: 24.0.sp,
          );
  }

  int getCountIndex() {
    var listOfIds = ref.watch(homeController);
    var listOfIdsLength = listOfIds
        .where(
          (element) => element!['category'] == widget.idAndObject!['type'],
        )
        .toList();
    return listOfIdsLength.length;
  }
}
