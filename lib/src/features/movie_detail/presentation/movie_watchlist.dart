import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seacinema/src/features/movie_detail/presentation/movies_watchlist_controller.dart';
import 'package:seacinema/src/features/movie_detail/presentation/widgets/movie_watch_item_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class WatchlistScreen extends StatefulHookConsumerWidget {
  const WatchlistScreen({Key? key}) : super(key: key);
  static const routeName = 'watchlist-screen';

  @override
  ConsumerState<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends ConsumerState<WatchlistScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final watchlistState = ref.watch(watchliztControllerProvider);

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watch list'),
        ),
        body: watchlistState!.isNotEmpty
            ? ListView.builder(
                itemCount: watchlistState.length,
                itemBuilder: (context, index) {
                  final watchlist = watchlistState[index];
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      MovieWatchItemWidget(
                        imagePath: watchlist.posterUrl?.split("w500/").last,
                        movie: {"id": watchlist.id},
                        title: watchlist.title,
                        rating: watchlist.ageRating?.toStringAsFixed(1),
                        date: DateFormat('dd MMM yyyy').format(DateTime.parse(watchlist.releaseDate.toString())),
                      ),
                      Positioned(
                        right: -10.0.sp,
                        top: -10.0.sp,
                        child: IconButton(
                          color: Colors.red.shade800,
                          onPressed: () {
                            ref.read(watchliztControllerProvider.notifier).removeFromWatchlist(watchlist);
                            setState(() {});
                          },
                          icon: const Icon(FontAwesomeIcons.circleXmark),
                        ),
                      )
                    ],
                  );
                },
                padding: EdgeInsets.only(top: 20.0.sp, left: 20.0.sp, right: 20.0.sp),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/watch-icon.png'),
                    Text(
                      'There is no movie yet!',
                      style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Find your movie by Type title, categories, years, etc ',
                      style: TextStyle(fontSize: 10.0.sp),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
