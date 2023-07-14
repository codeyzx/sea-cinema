import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacinema/src/features/auth/presentation/auth_controller.dart';
import 'package:seacinema/src/features/home/presentation/home_botnavbar_screen.dart';
import 'package:seacinema/src/features/payment/presentation/payment_screen.dart';
import 'package:seacinema/src/features/profile/presentation/edit_profile_screen.dart';

import 'package:go_router/go_router.dart';
import 'package:seacinema/src/common_config/app_theme.dart';
import 'package:seacinema/src/features/movie_detail/presentation/movie_watchlist.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = 'profile-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(authControllerProvider);

    return SafeArea(
      top: false,
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              width: 1.sw,
              height: 165.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.asset(
                          'assets/icons/profile.png',
                          width: 54.w,
                          height: 54.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 12.0.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 250.0.w,
                            child: Text(
                              '${users.name}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 250.w,
                            child: Text(
                              '@${users.username}',
                              style: TextStyle(
                                color: AppTheme.textBlueColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  const Text(
                    'Your Balance:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp',
                          decimalDigits: 0,
                        ).format(users.balance),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(width: 9.0),
                      // icon top up
                      InkWell(
                        onTap: () {
                          ref.read(currentIndexProvider.notifier).state = 2;
                          ref.read(currentScreenProvider.notifier).state = const PaymentScreen();
                        },
                        child: Container(
                          width: 14.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: AppTheme.textBlueColor,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: AppTheme.thirdColor,
              thickness: 1.h,
              height: 0.h,
            ),
            SizedBox(
              height: 18.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Account",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: () {
                      context.pushNamed(EditProfileScreen.routeName, extra: {
                        'user': users,
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/user-profile.png',
                          width: 25.w,
                          height: 25.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 282.w,
                          height: 33.h,
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Edit Profile",
                                style: TextStyle(
                                  color: AppTheme.textColorProfile,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppTheme.textColorProfile,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: () => context.pushNamed(WatchlistScreen.routeName),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/watchlist-icon.png',
                          width: 25.w,
                          height: 25.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 282.w,
                          height: 33.h,
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Watch List',
                                style: TextStyle(
                                  color: AppTheme.textColorProfile,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppTheme.textColorProfile,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Help",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/contact-icon.png',
                          width: 25.w,
                          height: 25.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 282.w,
                          height: 33.h,
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Contact',
                                style: TextStyle(
                                  color: AppTheme.textColorProfile,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppTheme.textColorProfile,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/report-icon.png',
                          width: 25.w,
                          height: 25.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 282.w,
                          height: 33.h,
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Report Problem",
                                style: TextStyle(
                                  color: AppTheme.textColorProfile,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppTheme.textColorProfile,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Other",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/terms-icon.png',
                          width: 25.w,
                          height: 25.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 282.w,
                          height: 33.h,
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Terms of Service",
                                style: TextStyle(
                                  color: AppTheme.textColorProfile,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppTheme.textColorProfile,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/privacy-icon.png',
                          width: 25.w,
                          height: 25.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 282.w,
                          height: 33.h,
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  color: AppTheme.textColorProfile,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppTheme.textColorProfile,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/rate-icon.png',
                          width: 25.w,
                          height: 25.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 282.w,
                          height: 33.h,
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rate",
                                style: TextStyle(
                                  color: AppTheme.textColorProfile,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppTheme.textColorProfile,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 42.h,
                  ),
                  InkWell(
                    onTap: () async {
                      await ref.read(authControllerProvider.notifier).signOut(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/icons/logout-icon.png',
                          width: 25.w,
                          height: 25.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 282.w,
                          height: 33.h,
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16.sp,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.red,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
