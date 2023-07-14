import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seacinema/src/features/orders/entities/orders.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderController extends StateNotifier<List<Orders>> {
  OrderController() : super(const []);

  final db = FirebaseFirestore.instance.collection('orders').withConverter<Orders>(
        fromFirestore: (snapshot, _) => Orders.fromJson(snapshot.data()!),
        toFirestore: (Orders orders, _) => orders.toJson(),
      );

  Future<String> add({required String userId, required Orders order}) async {
    final ref = db.doc();
    final temp = order.copyWith(id: ref.id);
    await ref.set(temp);
    await getData(userId);
    return ref.id;
  }

  Future<void> addTickets({required String userId, required Orders order, required String orderId}) async {
    final ref = FirebaseFirestore.instance.collection('tickets');
    final data = {
      'orderId': orderId,
      'movieId': order.movie!['id'],
      'seatId': order.seat,
      'status': true,
      'uid': userId,
    };
    for (String seat in order.seat!) {
      final seatData = {...data, 'seatId': seat};
      await ref.add(seatData);
    }
  }

  Future<void> buyTickets({required String userId, required int totalPayment, required int balance}) async {
    final newBalance = balance - totalPayment;
    await FirebaseFirestore.instance.collection('users').doc(userId).update({'balance': newBalance});
  }

  Future<void> cancelTickets({
    required String userId,
    required int totalPayment,
    required int balance,
    required List<String> seat,
    required String orderId,
  }) async {
    final ref = FirebaseFirestore.instance.collection('tickets');
    final refOrders = FirebaseFirestore.instance.collection('orders');

    final newBalance = balance + totalPayment;
    await FirebaseFirestore.instance.collection('users').doc(userId).update({'balance': newBalance});

    final dataOrders = {
      'statusPayment': false,
    };

    await refOrders.doc(orderId).update(dataOrders);

    final data = {
      'status': false,
    };
    await Future.wait(
      seat.map((seatId) async {
        final value = await ref.where('orderId', isEqualTo: orderId).where('seatId', isEqualTo: seatId).get();
        final id = value.docs.first.id;
        await ref.doc(id).update(data);
      }),
    );
  }

  Future<void> getData(String userId) async {
    final data = await db.where('uid', isEqualTo: userId).orderBy('createdAt', descending: true).get();
    state = data.docs.map((e) => e.data()).toList();
  }
}

final orderControllerProvider = StateNotifierProvider<OrderController, List<Orders>>(
  (ref) => OrderController(),
);
