import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seacinema/src/features/auth/presentation/auth_controller.dart';
import 'package:seacinema/src/features/payment/entities/payment.dart';
import 'package:seacinema/src/features/payment/presentation/payment_controller.dart';
import 'package:seacinema/src/features/payment/presentation/payment_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:quickalert/quickalert.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  static const routeName = 'payment-screen';
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PaymentScreen> createState() => PaymentScreenState();
}

class PaymentScreenState extends ConsumerState<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoadingButton = false;
  bool isLoading = false;
  MidtransSDK? _midtrans;

  final balanceController = TextEditingController();

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    final userId = ref.read(authControllerProvider).uid.toString();
    await ref.read(authControllerProvider.notifier).getUsers(uid: userId);
    await ref.read(paymentControllerProvider.notifier).getData(userId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider);
    final payment = ref.watch(paymentControllerProvider);

    return Scaffold(
      body: RefreshIndicator(
        color: Colors.orange,
        onRefresh: () async {
          await fetchData();
        },
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.all(16),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.blue.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Your Balance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              NumberFormat.currency(
                                locale: "id",
                                symbol: "Rp",
                                decimalDigits: 0,
                              ).format(user.balance),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Account Name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 150,
                              child: Text(
                                user.name.toString().split(' ').first,
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context).viewInsets.bottom,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                            child: Container(
                                              height: 5,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Top Up',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade300,
                                            ),
                                          ),
                                          Text(
                                            'Enter the amount you want to top up',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            height: 50,
                                            child: Form(
                                              key: _formKey,
                                              child: TextFormField(
                                                controller: balanceController,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Amount cannot be empty';
                                                  } else if (int.parse(value) < 10000) {
                                                    return 'Minimum top up is Rp 10.000';
                                                  }
                                                  return null;
                                                },
                                                keyboardType: TextInputType.number,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue.shade300,
                                                ),
                                                decoration: InputDecoration(
                                                  prefixIcon: Container(
                                                    margin: const EdgeInsets.only(right: 10),
                                                    height: 1.sh,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.only(
                                                        topLeft: Radius.circular(16),
                                                        bottomLeft: Radius.circular(16),
                                                      ),
                                                      color: Colors.blue.shade300,
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Rp',
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                                  hintText: '25.000',
                                                  hintStyle: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                if (_formKey.currentState!.validate()) {
                                                  setState(() {
                                                    isLoadingButton = true;
                                                  });
                                                  try {
                                                    String chars =
                                                        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

                                                    String random =
                                                        List.generate(15, (index) => chars[Random().nextInt(chars.length)])
                                                            .join();

                                                    int balance = int.parse(balanceController.text);

                                                    String item = 'Top Up Balance ${NumberFormat.currency(
                                                      locale: "id",
                                                      symbol: "Rp",
                                                      decimalDigits: 0,
                                                    ).format(balance)}';

                                                    final invoiceId = 'order-id-$random';

                                                    final payment = Payment(
                                                      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                                      invoiceId: invoiceId,
                                                      userId: user.uid.toString(),
                                                      items: item,
                                                      methodPayment: '',
                                                      statusPayment: '',
                                                      tokenPayment: '',
                                                      totalPayment: balance,
                                                      status: true,
                                                    );

                                                    await ref.read(paymentControllerProvider.notifier).add(
                                                          userId: user.uid.toString(),
                                                          payment: payment,
                                                          invoiceId: invoiceId,
                                                        );

                                                    await ref
                                                        .read(paymentControllerProvider.notifier)
                                                        .updateBalance(userId: user.uid.toString(), balance: balance);

                                                    await ref
                                                        .read(authControllerProvider.notifier)
                                                        .getUsers(uid: user.uid.toString());

                                                    await ref
                                                        .read(paymentControllerProvider.notifier)
                                                        .getData(user.uid.toString());

                                                    if (!mounted) return;
                                                    QuickAlert.show(
                                                      context: context,
                                                      type: QuickAlertType.success,
                                                      text: 'Top Up Completed Successfully!',
                                                      onConfirmBtnTap: () {
                                                        context.pop();
                                                        context.pop();
                                                      },
                                                      barrierDismissible: false,
                                                    );

                                                    setState(() {
                                                      isLoadingButton = false;
                                                    });
                                                  } catch (e) {
                                                    context.pop();
                                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        behavior: SnackBarBehavior.floating,
                                                        content: Text(e.toString()),
                                                        backgroundColor: Colors.red,
                                                      ),
                                                    );
                                                    setState(() {
                                                      isLoadingButton = false;
                                                    });
                                                  }
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.blue.shade300,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                              ),
                                              child: isLoadingButton
                                                  ? const SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child: CircularProgressIndicator(),
                                                    )
                                                  : const Text('Continue'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                if (_formKey.currentState!.validate()) {
                                                  setState(() {
                                                    isLoadingButton = true;
                                                  });
                                                  try {
                                                    final clientKey = dotenv.get('CLIENT_KEY');
                                                    final baseUrl = dotenv.get('BASE_URL_SEA');

                                                    _midtrans = await MidtransSDK.init(
                                                      config: MidtransConfig(
                                                        clientKey: clientKey,
                                                        merchantBaseUrl: baseUrl,
                                                      ),
                                                    );

                                                    _midtrans?.setUIKitCustomSetting(
                                                      skipCustomerDetailsPages: true,
                                                      showPaymentStatus: true,
                                                    );

                                                    String chars =
                                                        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                                                    String random =
                                                        List.generate(15, (index) => chars[Random().nextInt(chars.length)])
                                                            .join();

                                                    int balance = int.parse(balanceController.text);

                                                    String item = 'Top Up Balance ${NumberFormat.currency(
                                                      locale: "id",
                                                      symbol: "Rp",
                                                      decimalDigits: 0,
                                                    ).format(balance)}';

                                                    Map<String, dynamic> body = {
                                                      "order_id": random,
                                                      "customers": {
                                                        "email": "${user.username}@gmail.com",
                                                        "username": "${user.username}",
                                                      },
                                                      "url": "",
                                                      "items": [
                                                        {
                                                          "id": "1",
                                                          "price": balance,
                                                          "quantity": 1,
                                                          "name": item,
                                                        },
                                                      ],
                                                    };

                                                    final payment = Payment(
                                                      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                                      userId: user.uid.toString(),
                                                      items: item,
                                                      methodPayment: '',
                                                      statusPayment: '',
                                                      tokenPayment: '',
                                                      totalPayment: balance,
                                                      status: false,
                                                    );

                                                    final token =
                                                        await ref.read(paymentControllerProvider.notifier).getToken(body);

                                                    await _midtrans?.startPaymentUiFlow(
                                                      token: token,
                                                    );

                                                    _midtrans!.setTransactionFinishedCallback((result) async {
                                                      Logger().w('result ${result.toString()}');
                                                      Logger().w('status ${result.transactionStatus}');
                                                      Logger().w('is canceled ${result.isTransactionCanceled}');

                                                      if (!result.isTransactionCanceled) {
                                                        await ref.read(paymentControllerProvider.notifier).add(
                                                              userId: user.uid.toString(),
                                                              payment: payment,
                                                              invoiceId: result.orderId.toString(),
                                                            );

                                                        await ref
                                                            .read(authControllerProvider.notifier)
                                                            .getUsers(uid: user.uid.toString());

                                                        await ref
                                                            .read(paymentControllerProvider.notifier)
                                                            .getData(user.uid.toString());

                                                        if (!mounted) return;
                                                        QuickAlert.show(
                                                          context: context,
                                                          type: QuickAlertType.success,
                                                          text: 'Top Up Completed Successfully!',
                                                          onConfirmBtnTap: () {
                                                            context.pop();
                                                            context.pop();
                                                          },
                                                          barrierDismissible: false,
                                                        );
                                                      } else {
                                                        setState(() {
                                                          isLoadingButton = false;
                                                        });
                                                        context.pop();
                                                      }
                                                    });
                                                  } catch (e) {
                                                    context.pop();
                                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        behavior: SnackBarBehavior.floating,
                                                        content: Text(e.toString()),
                                                        backgroundColor: Colors.red,
                                                      ),
                                                    );
                                                    setState(() {
                                                      isLoadingButton = false;
                                                    });
                                                  }
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.purple.shade300,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                              ),
                                              child: isLoadingButton
                                                  ? const SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child: CircularProgressIndicator(),
                                                    )
                                                  : const Text('With Midtrans'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.blue.shade300,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('Top Up'),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context).viewInsets.bottom,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                            child: Container(
                                              height: 5,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Withdraw',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade300,
                                            ),
                                          ),
                                          Text(
                                            'Enter the amount you want to withdraw',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            height: 50,
                                            child: Form(
                                              key: _formKey,
                                              child: TextFormField(
                                                controller: balanceController,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Amount cannot be empty';
                                                  } else if (int.parse(value) < 10000) {
                                                    return 'Minimum withdraw is Rp 10.000';
                                                  } else if (int.parse(value) > user.balance!.toInt()) {
                                                    return 'Insufficient balance';
                                                  } else if (int.parse(value) > 500000) {
                                                    return 'Maximum withdraw is Rp 500.000';
                                                  }
                                                  return null;
                                                },
                                                keyboardType: TextInputType.number,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue.shade300,
                                                ),
                                                decoration: InputDecoration(
                                                  prefixIcon: Container(
                                                    margin: const EdgeInsets.only(right: 10),
                                                    height: 1.sh,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.only(
                                                        topLeft: Radius.circular(16),
                                                        bottomLeft: Radius.circular(16),
                                                      ),
                                                      color: Colors.blue.shade300,
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Rp',
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                                  hintText: '25.000',
                                                  hintStyle: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                if (_formKey.currentState!.validate()) {
                                                  setState(() {
                                                    isLoadingButton = true;
                                                  });
                                                  try {
                                                    int balance = int.parse(balanceController.text);

                                                    await ref
                                                        .read(paymentControllerProvider.notifier)
                                                        .withdrawBalance(userId: user.uid.toString(), balance: balance);

                                                    await ref
                                                        .read(authControllerProvider.notifier)
                                                        .getUsers(uid: user.uid.toString());

                                                    await ref
                                                        .read(paymentControllerProvider.notifier)
                                                        .getData(user.uid.toString());

                                                    if (!mounted) return;

                                                    QuickAlert.show(
                                                      context: context,
                                                      type: QuickAlertType.success,
                                                      text: 'Withdraw Completed Successfully!',
                                                      onConfirmBtnTap: () {
                                                        context.pop();
                                                        context.pop();
                                                      },
                                                      barrierDismissible: false,
                                                    );

                                                    setState(() {
                                                      isLoadingButton = false;
                                                    });
                                                  } catch (e) {
                                                    context.pop();
                                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        behavior: SnackBarBehavior.floating,
                                                        content: Text(e.toString()),
                                                        backgroundColor: Colors.red,
                                                      ),
                                                    );
                                                    setState(() {
                                                      isLoadingButton = false;
                                                    });
                                                  }
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: Colors.blue.shade300,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                              ),
                                              child: isLoadingButton
                                                  ? const SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child: CircularProgressIndicator(),
                                                    )
                                                  : const Text('Continue'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.blue.shade300,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('Withdraw'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              'History Top Up',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : payment.isEmpty
                      ? Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey,
                          ),
                          margin: const EdgeInsets.all(16),
                          child: const Center(
                            child: Text('You dont have any top up history'),
                          ),
                        )
                      : ListView.builder(
                          itemCount: payment.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                              child: InkWell(
                                onTap: () {
                                  if (payment[index].statusPayment == "" && payment[index].status == true) {
                                    return;
                                  }
                                  context.pushNamed(PaymentDetailScreen.routeName, extra: {
                                    'payment': payment[index],
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blue.shade300,
                                      child: const Icon(
                                        Icons.payment,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: const Text('Top Up Balance'),
                                    subtitle: Text(
                                      NumberFormat.currency(
                                        locale: "id",
                                        symbol: "Rp",
                                        decimalDigits: 0,
                                      ).format(payment[index].totalPayment),
                                    ),
                                    trailing: Visibility(
                                      visible:
                                          payment[index].statusPayment == "" && payment[index].status == true ? false : true,
                                      child: Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: payment[index].statusPayment == "settlement"
                                              ? Colors.green.shade300
                                              : payment[index].statusPayment == "failure"
                                                  ? Colors.red.shade300
                                                  : Colors.grey.shade300,
                                        ),
                                        child: Center(
                                          child: Text(
                                            payment[index].statusPayment == "settlement"
                                                ? "Success"
                                                : payment[index].statusPayment == "failure"
                                                    ? "Failed"
                                                    : payment[index].statusPayment.toString(),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: payment[index].statusPayment == "settlement" ||
                                                      payment[index].statusPayment == "failure"
                                                  ? Colors.white
                                                  : Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
