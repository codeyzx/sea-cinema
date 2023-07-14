import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seacinema/src/common_config/app_theme.dart';
import 'package:seacinema/src/features/home/presentation/home_screen.dart';
import 'package:seacinema/src/features/orders/presentation/orders_screen.dart';
import 'package:seacinema/src/features/payment/presentation/payment_screen.dart';
import 'package:seacinema/src/features/profile/presentation/profile_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentScreenProvider = StateProvider<Widget>((ref) => const HomeScreen());
final currentIndexProvider = StateProvider<int>((ref) => 0);

class HomeBotNavBarScreen extends StatefulHookConsumerWidget {
  const HomeBotNavBarScreen({Key? key}) : super(key: key);
  static const routeName = '/botnavbar-screen';

  @override
  HomeBotNavBarScreenState createState() => HomeBotNavBarScreenState();
}

class HomeBotNavBarScreenState extends ConsumerState<HomeBotNavBarScreen> {
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final currentScreen = ref.watch(currentScreenProvider);
    final currentIndex = ref.watch(currentIndexProvider);

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 1.5.sp),
          decoration: const BoxDecoration(
            color: AppTheme.textBlueColor,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 25.0.sp,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                ref.read(currentIndexProvider.notifier).state = index;
                switch (index) {
                  case 0:
                    ref.read(currentScreenProvider.notifier).state = const HomeScreen();
                    break;
                  case 1:
                    ref.read(currentScreenProvider.notifier).state = const OrderScreen();
                    break;
                  case 2:
                    ref.read(currentScreenProvider.notifier).state = const PaymentScreen();
                    break;
                  case 3:
                    ref.read(currentScreenProvider.notifier).state = const ProfileScreen();
                    break;
                  default:
                }
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Icon(FontAwesomeIcons.houseChimney),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Icon(FontAwesomeIcons.ticket),
                  ),
                  label: 'Tickets'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Icon(FontAwesomeIcons.creditCard),
                  ),
                  label: 'Payment'),
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(top: 8.0), child: Icon(FontAwesomeIcons.user)),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
