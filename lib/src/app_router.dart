import 'package:flutter/material.dart';
import 'package:seacinema/src/features/auth/presentation/sign_in_screen.dart';
import 'package:seacinema/src/features/auth/presentation/sign_up_screen.dart';
import 'package:seacinema/src/features/booking/presentation/booking_detail_screen.dart';
import 'package:seacinema/src/features/booking/presentation/booking_screen.dart';
import 'package:seacinema/src/features/home/presentation/home_botnavbar_screen.dart';
import 'package:seacinema/src/features/movie_detail/presentation/movie_watchlist.dart';
import 'package:seacinema/src/features/movie_detail/presentation/movies_detail_screen.dart';
import 'package:seacinema/src/features/orders/presentation/orders_detail_screen.dart';
import 'package:seacinema/src/features/orders/presentation/orders_screen.dart';
import 'package:seacinema/src/features/payment/presentation/payment_detail_screen.dart';
import 'package:seacinema/src/features/payment/presentation/payment_screen.dart';
import 'package:seacinema/src/features/profile/presentation/edit_profile_screen.dart';
import 'package:seacinema/src/features/profile/presentation/profile_screen.dart';
import 'package:go_router/go_router.dart';

import 'features/home/presentation/home_screen.dart';
import 'features/starter/presentation/splash_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: SplashScreen.routeName,
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        key: state.pageKey,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
        path: '/sign-in-screen',
        name: SignInScreen.routeName,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              key: state.pageKey,
              child: const SignInScreen(),
            ),
        routes: const []),
    GoRoute(
        path: '/sign-up-screen',
        name: SignUpScreen.routeName,
        pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const SignUpScreen(),
            ),
        routes: const []),
    GoRoute(
        path: '/botnavbar-screen',
        name: HomeBotNavBarScreen.routeName,
        pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const HomeBotNavBarScreen(),
            ),
        routes: const []),
    GoRoute(
        path: '/home-screen',
        name: HomeScreen.routeName,
        pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const HomeScreen(),
            ),
        routes: const []),
    GoRoute(
        path: '/payment-screen',
        name: PaymentScreen.routeName,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              key: state.pageKey,
              child: const PaymentScreen(),
            ),
        routes: const []),
    GoRoute(
        path: '/payment-detail-screen',
        name: PaymentDetailScreen.routeName,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return CustomTransitionPage<void>(
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: child,
              );
            },
            child: PaymentDetailScreen(
              data: data,
            ),
          );
        }),
    GoRoute(
        path: '/order-screen',
        name: OrderScreen.routeName,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              key: state.pageKey,
              child: const OrderScreen(),
            ),
        routes: const []),
    GoRoute(
        path: '/orders-detail-screen',
        name: OrdersDetailScreen.routeName,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return CustomTransitionPage<void>(
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: child,
              );
            },
            child: OrdersDetailScreen(
              data: data,
            ),
          );
        }),
    GoRoute(
        path: '/profile-screen',
        name: ProfileScreen.routeName,
        pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: const ProfileScreen(),
            ),
        routes: const []),
    GoRoute(
        path: '/edit-profile-screen',
        name: EditProfileScreen.routeName,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return CustomTransitionPage<void>(
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: child,
              );
            },
            child: EditProfileScreen(
              data: data,
            ),
          );
        }),
    GoRoute(
        path: '/movies-screen',
        name: MoviesDetailScreen.routeName,
        pageBuilder: (context, state) {
          final movieId = state.extra as Map<String, dynamic>;
          return CustomTransitionPage<void>(
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: child,
              );
            },
            child: MoviesDetailScreen(
              idAndObject: movieId,
            ),
          );
        }),
    GoRoute(
      path: '/watchlist-screen',
      name: WatchlistScreen.routeName,
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const WatchlistScreen(),
      ),
    ),
    GoRoute(
        path: '/booking-screen',
        name: BookingScreen.routeName,
        pageBuilder: (context, state) {
          final movieId = state.extra as Map<String, dynamic>;
          return CustomTransitionPage<void>(
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: child,
              );
            },
            child: BookingScreen(
              movId: movieId,
            ),
          );
        }),
    GoRoute(
        path: '/booking-detail-screen',
        name: BookingDetailScreen.routeName,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return CustomTransitionPage<void>(
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: child,
              );
            },
            child: BookingDetailScreen(
              data: data,
            ),
          );
        }),
  ],
);
