import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacinema/src/features/booking/presentation/booking_screen.dart';
import 'package:seacinema/src/features/home/domain/entities/movies.dart';
import 'package:go_router/go_router.dart';

class AboutMovie extends StatelessWidget {
  final int? age;
  final Movies? movie;
  final String? movieTitle;
  final String content;
  final Color? color;
  const AboutMovie({
    Key? key,
    this.age,
    this.movie,
    this.movieTitle,
    required this.content,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.sp, vertical: 10.0.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieTitle ?? '',
                    style: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.bold),
                  )
                      .animate()
                      .fadeIn(curve: Curves.easeOutCirc)
                      .then(delay: 200.ms)
                      .untint(color: color)
                      .blurXY(begin: 16)
                      .scaleXY(begin: 1.5),
                  SizedBox(height: 10.0.sp),
                  Text(content),
                ],
              ),
            ),
          ),
        ),
        movie == null
            ? SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.sp, vertical: 10.0.sp),
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: color),
                    onPressed: () {},
                    child: Text(
                      'Book Ticket',
                      style: TextStyle(color: color == Colors.white ? Colors.black : Colors.white),
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.sp, vertical: 10.0.sp),
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: color),
                    onPressed: () {
                      if (age! < movie!.ageRating!) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('You are not old enough to watch this movie'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        context.pushNamed(BookingScreen.routeName, extra: {
                          'movie': movie,
                        });
                      }
                    },
                    child: Text(
                      'Book Ticket',
                      style: TextStyle(color: color == Colors.white ? Colors.black : Colors.white),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
