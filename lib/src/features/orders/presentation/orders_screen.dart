import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seacinema/src/features/auth/presentation/auth_controller.dart';
import 'package:seacinema/src/features/orders/presentation/orders_controller.dart';
import 'package:seacinema/src/features/orders/presentation/orders_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class OrderScreen extends ConsumerStatefulWidget {
  static const routeName = 'order-screen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    final userId = ref.read(authControllerProvider).uid;
    await ref.read(orderControllerProvider.notifier).getData(userId.toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderControllerProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 52.h,
              ),
              Text(
                "Your Tickets",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : orders.isEmpty
                      ? Container(
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey,
                          ),
                          margin: const EdgeInsets.all(16),
                          child: const Center(
                            child: Text('You dont have any tickets'),
                          ),
                        )
                      : ListView.builder(
                          itemCount: orders.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: ElevatedButton(
                                onPressed: () async {
                                  context.pushNamed(OrdersDetailScreen.routeName, extra: {
                                    'order': orders[index],
                                  });
                                },
                                style:
                                    ElevatedButton.styleFrom(backgroundColor: Colors.transparent, padding: EdgeInsets.zero),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                                  width: 324.w,
                                  height: 103.h,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF0296E5).withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(6.r),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0xFF0296E5).withOpacity(0.6),
                                            blurRadius: 4,
                                            spreadRadius: 0,
                                            offset: const Offset(0, 2))
                                      ]),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: 'Rp',
                                                  decimalDigits: 0,
                                                ).format(orders[index].totalPayment),
                                              ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Container(
                                                width: 1.w,
                                                height: 15.h,
                                                color: Colors.black.withOpacity(0.60),
                                              ),
                                              SizedBox(
                                                width: 8.w,
                                              ),
                                              Text('${orders[index].seat?.length} Ticket'),
                                            ],
                                          ),
                                          orders[index].statusPayment == true
                                              ? Container(
                                                  padding: const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    color: HexColor('#16FF00').withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(6.r),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Success',
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight: FontWeight.w500,
                                                        color: HexColor('#16FF00'),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  padding: const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    color: HexColor('#B31312').withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(6.r),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Failed',
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight: FontWeight.w500,
                                                        color: HexColor('#B31312'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Expanded(
                                        child: Text(
                                          orders[index].movie!['title'].toString(),
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        DateFormat('dd MMMM yyyy, HH:mm').format(
                                            DateTime.fromMillisecondsSinceEpoch(int.tryParse(orders[index].createdAt!)!)),
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
