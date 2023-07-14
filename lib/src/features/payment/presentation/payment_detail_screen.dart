import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacinema/src/features/payment/entities/payment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class PaymentDetailScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? data;
  static const routeName = 'payment-detail-screen';
  const PaymentDetailScreen({Key? key, this.data}) : super(key: key);

  @override
  ConsumerState<PaymentDetailScreen> createState() => PaymentDetailScreenState();
}

class PaymentDetailScreenState extends ConsumerState<PaymentDetailScreen> {
  bool isLoading = false;
  Payment? payment;

  @override
  void initState() {
    super.initState();
    getPayment();
  }

  void getPayment() {
    setState(() {
      isLoading = true;
    });
    payment = widget.data!['payment'];
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Up Detail"),
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
                      SizedBox(height: 24.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                        decoration: BoxDecoration(color: const Color(0xff0e0f20), borderRadius: BorderRadius.circular(6.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Status Transaction", style: TextStyle(fontWeight: FontWeight.bold)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: payment?.statusPayment == "settlement"
                                    ? Colors.green.shade300
                                    : payment?.statusPayment == "failure"
                                        ? Colors.red.shade300
                                        : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Center(
                                child: Text(
                                  // "Success",
                                  payment?.statusPayment == 'settlement' ? 'Success' : '${payment?.statusPayment}',

                                  style: TextStyle(
                                      color: payment?.statusPayment == "settlement" || payment?.statusPayment == "failure"
                                          ? Colors.white
                                          : Colors.grey.shade600,
                                      fontSize: 14.sp),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                        decoration: BoxDecoration(color: const Color(0xff0e0f20), borderRadius: BorderRadius.circular(6.r)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Date Transaction", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              // "12 Januari 2021",
                              DateFormat('dd MMMM yyyy')
                                  .format(DateTime.fromMillisecondsSinceEpoch(int.tryParse(payment!.createdAt!)!)),
                              style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                        width: 1.sw,
                        decoration: BoxDecoration(color: const Color(0xff0e0f20), borderRadius: BorderRadius.circular(6.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Payment Summary",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              // "BNI - 1234567890",
                              payment?.methodPayment == 'gopay'
                                  ? '${payment?.methodPayment}'
                                  : '${payment?.methodPayment} - ${payment?.tokenPayment}',
                              style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                        width: 1.sw,
                        decoration: BoxDecoration(color: const Color(0xff0e0f20), borderRadius: BorderRadius.circular(6.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total Payment",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              // "Rp100.000",
                              NumberFormat.currency(
                                locale: "id",
                                symbol: "Rp",
                                decimalDigits: 0,
                              ).format(payment?.totalPayment),
                              style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
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
