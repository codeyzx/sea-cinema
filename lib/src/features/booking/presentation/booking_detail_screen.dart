import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacinema/src/features/auth/presentation/auth_controller.dart';
import 'package:seacinema/src/features/home/presentation/home_botnavbar_screen.dart';
import 'package:seacinema/src/features/orders/entities/orders.dart';
import 'package:seacinema/src/features/orders/presentation/orders_controller.dart';
import 'package:seacinema/src/features/payment/presentation/payment_screen.dart';
import 'package:seacinema/src/features/movie_detail/presentation/widgets/movie_item_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:quickalert/quickalert.dart';

class BookingDetailScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? data;
  const BookingDetailScreen({Key? key, this.data}) : super(key: key);

  static const routeName = 'booking-detail-screen';

  @override
  ConsumerState<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends ConsumerState<BookingDetailScreen> {
  bool isLoading = false;
  int? age;

  @override
  void initState() {
    super.initState();
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
    final users = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200.h,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://image.tmdb.org/t/p/w780/${widget.data?['movie'].posterUrl?.split("w500/").last}",
                          height: 150.h,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20.h,
                          left: 15.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 210.w,
                              child: Text(
                                widget.data?['movie'].title ?? '',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Text(
                                    '${widget.data?['movie'].ageRating}+',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: const Color(0xff0e0f20),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    color: Colors.yellowAccent.shade400,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Text(
                                    NumberFormat.currency(
                                      locale: "id",
                                      symbol: "Rp",
                                      decimalDigits: 0,
                                    ).format(widget.data?['movie'].ticketPrice),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: const Color(0xff0e0f20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              width: 210.w,
                              height: 78.h,
                              child: Text(
                                widget.data?['movie'].description.toString() ?? '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail Transaction",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          height: 1.h,
                          color: Colors.grey.shade200,
                        ),
                        Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        Divider(
                          height: 1.h,
                          color: Colors.grey.shade200,
                        ),
                        Text(
                          '${users.name}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        Text(
                          '$age years old',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Divider(
                          height: 1.h,
                          color: Colors.grey.shade200,
                        ),
                        Text(
                          "Seat Number",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        Divider(
                          height: 1.h,
                          color: Colors.grey.shade200,
                        ),
                        Text(
                          '${widget.data?['seat'].join(', ')}'.toUpperCase(),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: SizedBox(
        width: 1.sw,
        height: 140.h,
        child: Column(
          children: [
            Divider(
              height: 1.h,
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "YOUR BALANCE",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: "id",
                      symbol: "Rp",
                      decimalDigits: 0,
                    ).format(users.balance),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1.h,
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 7.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PAYMENT TOTAL",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: "id",
                      symbol: "Rp",
                      decimalDigits: 0,
                    ).format(widget.data?['totalPrice']),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                child: SizedBox(
                  width: 1.sw,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!isLoading) {
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          final order = Orders(
                            createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                            movie: widget.data?['movie'].toJson(),
                            seat: widget.data?['seat'],
                            totalPayment: widget.data?['totalPrice'],
                            statusPayment: true,
                            uid: users.uid,
                          );
                          final balance =
                              await ref.read(authControllerProvider.notifier).getBalances(userId: users.uid.toString());

                          if (balance >= widget.data?['totalPrice']) {
                            await ref.read(orderControllerProvider.notifier).buyTickets(
                                userId: users.uid.toString(), totalPayment: widget.data?['totalPrice'], balance: balance);

                            final orderId = await ref
                                .read(orderControllerProvider.notifier)
                                .add(userId: users.uid.toString(), order: order);

                            await ref
                                .read(orderControllerProvider.notifier)
                                .addTickets(userId: users.uid.toString(), order: order, orderId: orderId);

                            await ref.read(authControllerProvider.notifier).getUsers(uid: users.uid.toString());

                            setState(() {
                              isLoading = false;
                            });

                            if (!mounted) return;
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Transaction Completed Successfully!',
                              onConfirmBtnTap: () {
                                context.goNamed(HomeBotNavBarScreen.routeName);
                              },
                              barrierDismissible: false,
                            );
                          } else {
                            setState(() {
                              isLoading = false;
                            });

                            if (!mounted) return;
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Oops...',
                              text: 'Your balance is not enough',
                              showCancelBtn: true,
                              confirmBtnText: 'Top Up',
                              confirmBtnColor: Colors.green.withOpacity(0.9),
                              onConfirmBtnTap: () {
                                ref.read(movieDetailAccessFromProvider.notifier).state = HomeBotNavBarScreen.routeName;
                                ref.read(currentIndexProvider.notifier).state = 2;
                                ref.read(currentScreenProvider.notifier).state = const PaymentScreen();
                                context.goNamed(HomeBotNavBarScreen.routeName);
                              },
                            );
                          }
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          Logger().w(e.toString());
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(e.toString()),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0e0f20),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Checkout",
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
