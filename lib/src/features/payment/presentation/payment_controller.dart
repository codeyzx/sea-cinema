import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:seacinema/src/core/client/dio_client.dart';
import 'package:seacinema/src/features/payment/entities/payment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentController extends StateNotifier<List<Payment>> {
  PaymentController() : super(const []);

  final db = FirebaseFirestore.instance.collection('payments').withConverter<Payment>(
        fromFirestore: (snapshot, _) => Payment.fromJson(snapshot.data()!),
        toFirestore: (Payment payment, _) => payment.toJson(),
      );

  Future<void> add({required String userId, required Payment payment, required String invoiceId}) async {
    final ref = db.doc();
    final temp = payment.copyWith(id: ref.id, invoiceId: invoiceId);
    await ref.set(temp);
    await getData(userId);
  }

  Future<void> getData(String userId) async {
    final data = await db.where('userId', isEqualTo: userId).orderBy('createdAt', descending: true).get();
    state = data.docs.map((e) => e.data()).toList();
  }

  Future<void> updateBalance({required String userId, required int balance}) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'balance': FieldValue.increment(balance),
    });
  }

  Future<void> withdrawBalance({required String userId, required int balance}) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'balance': FieldValue.increment(-balance),
    });
  }

  Future<String> getToken(Map<String, dynamic> body) async {
    var resp = await DioClient(
      baseUrl: dotenv.get('BASE_URL_SEA'),
    ).apiCall(
      url: '/charge',
      requestType: RequestType.post,
      body: body,
    );

    String token = resp.data['token'];
    return token;
  }
}

final paymentControllerProvider = StateNotifierProvider<PaymentController, List<Payment>>(
  (ref) => PaymentController(),
);
