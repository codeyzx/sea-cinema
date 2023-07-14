import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seacinema/src/features/auth/presentation/auth_controller.dart';
import 'package:seacinema/src/features/home/domain/entities/movies.dart';
import 'package:seacinema/src/features/home/presentation/home_botnavbar_screen.dart';
import 'package:seacinema/src/features/orders/entities/orders.dart';
import 'package:seacinema/src/features/orders/presentation/orders_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:quickalert/quickalert.dart';

class OrdersDetailScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? data;
  const OrdersDetailScreen({Key? key, this.data}) : super(key: key);

  static const routeName = 'orders-detail-screen';

  @override
  ConsumerState<OrdersDetailScreen> createState() => _OrdersDetailScreenState();
}

class _OrdersDetailScreenState extends ConsumerState<OrdersDetailScreen> {
  bool isLoading = false;
  bool isLoadingBtn = false;

  Movies? movie;
  Orders? order;
  int? age;

  @override
  void initState() {
    super.initState();
    getData();

    getUserAge();
  }

  void getData() {
    setState(() {
      isLoading = true;
      movie = Movies.fromJson(widget.data?['order'].movie);
      order = Orders.fromJson(widget.data?['order'].toJson());
    });
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
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Summary"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200.h,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              child: CachedNetworkImage(
                                imageUrl: "https://image.tmdb.org/t/p/w780/${movie?.posterUrl?.split("w500/").last}",
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
                                      movie?.title ?? '',
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
                                          '${movie?.ageRating}+',
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
                                          ).format(movie?.ticketPrice),
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
                                      movie?.description.toString() ?? '',
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Divider(
                                height: 1.h,
                                color: Colors.grey.shade200,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Show Time",
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
                                    DateFormat('dd MMMM yyyy').format(DateTime.tryParse(movie!.releaseDate!.toString())!),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Divider(
                                height: 1.h,
                                color: Colors.grey.shade200,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                    '${order?.seat?.join(', ')}'.toUpperCase(),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Divider(
                                height: 1.h,
                                color: Colors.grey.shade200,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Payment",
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
                                    NumberFormat.currency(
                                      locale: "id",
                                      symbol: "Rp",
                                      decimalDigits: 0,
                                    ).format(order?.totalPayment),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50.sp),
                        child: SizedBox(
                          width: 1.sw,
                          height: 80.h,
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  child: SizedBox(
                                    width: 1.sw,
                                    child: order!.statusPayment!
                                        ? InkWell(
                                            onTap: () async {
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.confirm,
                                                title: 'Cancel Ticket?',
                                                confirmBtnText: 'Yes',
                                                cancelBtnText: 'No',
                                                confirmBtnColor: Colors.green,
                                                onConfirmBtnTap: () async {
                                                  try {
                                                    setState(() {
                                                      isLoadingBtn = true;
                                                    });
                                                    final balance = await ref
                                                        .read(authControllerProvider.notifier)
                                                        .getBalances(userId: users.uid.toString());

                                                    await ref.read(orderControllerProvider.notifier).cancelTickets(
                                                          userId: users.uid.toString(),
                                                          totalPayment: order!.totalPayment!,
                                                          balance: balance,
                                                          seat: order!.seat!,
                                                          orderId: order!.id!,
                                                        );

                                                    await ref
                                                        .read(orderControllerProvider.notifier)
                                                        .getData(users.uid.toString());

                                                    await ref
                                                        .read(authControllerProvider.notifier)
                                                        .getUsers(uid: users.uid.toString());

                                                    setState(() {
                                                      isLoadingBtn = false;
                                                    });

                                                    if (!mounted) return;
                                                    QuickAlert.show(
                                                      context: context,
                                                      type: QuickAlertType.success,
                                                      title: 'Success Cancel Ticket!',
                                                      onConfirmBtnTap: () {
                                                        context.goNamed(HomeBotNavBarScreen.routeName);
                                                      },
                                                      barrierDismissible: false,
                                                    );
                                                  } catch (e) {
                                                    setState(() {
                                                      isLoadingBtn = false;
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
                                                },
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: HexColor('#B31312').withOpacity(0.9),
                                              ),
                                              child: Center(
                                                child: isLoadingBtn
                                                    ? const SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child: CircularProgressIndicator(
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    : const Text(
                                                        "Cancel Ticket",
                                                      ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              color: HexColor('#B31312').withOpacity(0.3),
                                            ),
                                            child: Center(
                                              child: isLoadingBtn
                                                  ? const SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child: CircularProgressIndicator(
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : const Text(
                                                      "Cancel Ticket",
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
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
