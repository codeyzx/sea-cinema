import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacinema/src/features/auth/presentation/auth_controller.dart';
import 'package:seacinema/src/features/auth/presentation/sign_in_screen.dart';
import 'package:seacinema/src/features/home/presentation/home_botnavbar_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_config/palette.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = 'splashScreen';

  @override
  ConsumerState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initPage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        backgroundColor: Palette.color,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/icons/splash_icon.png",
                height: 200.h,
                width: 200.w,
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initPage() async {
    final users = await ref.read(authControllerProvider.notifier).checkUsers();

    Future.delayed(const Duration(seconds: 2), () {
      if (users != '') {
        context.goNamed(HomeBotNavBarScreen.routeName);
      } else {
        context.goNamed(SignInScreen.routeName);
      }
    });
  }
}
