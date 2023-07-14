import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seacinema/src/features/booking/entities/seat.dart';
import 'package:seacinema/src/features/booking/presentation/booking_detail_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:go_router/go_router.dart';

class BookingScreen extends StatefulHookConsumerWidget {
  final Map<String, dynamic>? movId;
  const BookingScreen({
    Key? key,
    this.movId,
  }) : super(key: key);

  static const routeName = 'booking-screen';

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  late StreamProvider statusBookingProvider;

  Set<SeatNumber> selectedSeats = {};
  List<List<SeatState>> currentSeat = List.generate(8, (row) {
    return List.generate(9, (col) {
      if (col == 4) {
        return SeatState.empty;
      } else {
        return SeatState.unselected;
      }
    });
  });

  @override
  void initState() {
    super.initState();
    setProvider();
  }

  void setProvider() {
    statusBookingProvider = StreamProvider((ref) {
      final snapshots = FirebaseFirestore.instance
          .collection('tickets')
          .where(
            'movieId',
            isEqualTo: widget.movId?['movie'].id,
          )
          .where(
            'status',
            isEqualTo: true,
          )
          .snapshots();
      return snapshots.map((QuerySnapshot querySnapshot) {
        final List<QueryDocumentSnapshot> documents = querySnapshot.docs;
        documents.sort((a, b) => a['seatId'].compareTo(b['seatId']));

        final List<String> seatIdList = [];
        for (var document in documents) {
          final seatId = document['seatId'];
          seatIdList.add(seatId);
        }

        currentSeat = List.generate(8, (row) {
          return List.generate(9, (col) {
            if (col == 4) {
              return SeatState.empty;
            } else {
              return SeatState.unselected;
            }
          });
        });

        for (String seatId in seatIdList) {
          int row = seatId.codeUnitAt(0) - 97;
          int col = int.parse(seatId.substring(1)) - 1;

          currentSeat[row][col] = SeatState.sold;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusList = ref.watch(statusBookingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seat Layout"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg_unselected_seat.svg',
                        width: 15,
                        height: 15,
                      ),
                      const Text('Available')
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg_sold_seat.svg',
                        width: 15,
                        height: 15,
                      ),
                      const Text('Sold')
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg_selected_seats.svg',
                        width: 15,
                        height: 15,
                      ),
                      const Text('Selected by you')
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.black.withOpacity(0.2),
            ),
            const SizedBox(
              height: 16,
            ),
            Flexible(
              child: SizedBox(
                width: 1.sw,
                height: 500.h,
                child: statusList.when(
                  data: (data) {
                    Logger().wtf("data: $data");
                    return InteractiveViewer(
                      maxScale: 5,
                      minScale: 0.8,
                      boundaryMargin: const EdgeInsets.all(8),
                      constrained: true,
                      child: Column(
                        children: [
                          ...List<int>.generate(8, (rowI) => rowI)
                              .map<Row>(
                                (rowI) => Row(
                                  children: [
                                    ...List<int>.generate(9, (colI) => colI)
                                        .map((colI) => GestureDetector(
                                              onTapUp: (_) {
                                                if (selectedSeats.length == 6 &&
                                                    currentSeat[rowI][colI] == SeatState.unselected) {
                                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      behavior: SnackBarBehavior.floating,
                                                      content: Text('You can select only 6 seats'),
                                                    ),
                                                  );
                                                } else {
                                                  switch (currentSeat[rowI][colI]) {
                                                    case SeatState.selected:
                                                      {
                                                        setState(() {
                                                          currentSeat[rowI][colI] = SeatState.unselected;
                                                          selectedSeats.remove(SeatNumber(rowI: rowI, colI: colI));
                                                        });
                                                      }
                                                      break;
                                                    case SeatState.unselected:
                                                      {
                                                        setState(() {
                                                          currentSeat[rowI][colI] = SeatState.selected;
                                                          selectedSeats.add(SeatNumber(rowI: rowI, colI: colI));
                                                        });
                                                      }
                                                      break;
                                                    case SeatState.disabled:
                                                    case SeatState.sold:
                                                    case SeatState.empty:
                                                    default:
                                                      {}
                                                      break;
                                                  }
                                                }
                                              },
                                              child: currentSeat[rowI][colI] != SeatState.empty
                                                  ? SvgPicture.asset(
                                                      _getSvgPath(
                                                        currentSeat[rowI][colI],
                                                      ),
                                                      height: 40.toDouble(),
                                                      width: 40.toDouble(),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : SizedBox(
                                                      height: 40.toDouble(),
                                                      width: 40.toDouble(),
                                                    ),
                                            ))
                                        .toList()
                                  ],
                                ),
                              )
                              .toList()
                        ],
                      ),
                    );
                  },
                  loading: () => InteractiveViewer(
                    maxScale: 5,
                    minScale: 0.8,
                    boundaryMargin: const EdgeInsets.all(8),
                    constrained: true,
                    child: Column(
                      children: [
                        ...List<int>.generate(8, (rowI) => rowI)
                            .map<Row>(
                              (rowI) => Row(
                                children: [
                                  ...List<int>.generate(9, (colI) => colI)
                                      .map((colI) => GestureDetector(
                                            child: currentSeat[rowI][colI] != SeatState.empty
                                                ? SvgPicture.asset(
                                                    _getSvgPath(
                                                      currentSeat[rowI][colI],
                                                    ),
                                                    height: 40.toDouble(),
                                                    width: 40.toDouble(),
                                                    fit: BoxFit.cover,
                                                  )
                                                : SizedBox(
                                                    height: 40.toDouble(),
                                                    width: 40.toDouble(),
                                                  ),
                                          ))
                                      .toList()
                                ],
                              ),
                            )
                            .toList()
                      ],
                    ),
                  ),
                  error: (e, s) => Expanded(
                      child: Center(
                    child: Text(
                      'Something Error):',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 1.sw,
                  height: 20.h,
                  color: Colors.grey.shade400,
                  child: Center(
                    child: Text(
                      'THE SCREEN IS HERE',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Total Price: ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          NumberFormat.currency(
                            locale: "id",
                            symbol: "Rp",
                            decimalDigits: 0,
                          ).format(selectedSeats.length * widget.movId?['movie'].ticketPrice),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50.h,
                      width: 1,
                      color: Colors.white,
                    ),
                    Column(
                      children: [
                        Text(
                          "Total Seats: ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${selectedSeats.length}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 1.sw,
                  height: 65.h,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: const Color(0xff0e0f20)),
                    onPressed: () async {
                      if (selectedSeats.isNotEmpty) {
                        List<List<int>> seatsList = selectedSeats.map((seat) => [seat.rowI, seat.colI]).toList();
                        List<String> seats = seatsList.map((coord) {
                          String letter = String.fromCharCode('a'.codeUnitAt(0) + coord[0]);
                          int number = coord[1] + 1;
                          return '$letter$number';
                        }).toList();

                        context.pushNamed(BookingDetailScreen.routeName, extra: {
                          'movie': widget.movId?['movie'],
                          'seat': seats,
                          'totalPrice': selectedSeats.length * widget.movId?['movie'].ticketPrice,
                        });
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('Please select at least 1 seat'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Book Ticket',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI && colI == (other).colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[$rowI][$colI]';
  }
}

String _getSvgPath(SeatState state) {
  switch (state) {
    case SeatState.unselected:
      {
        return 'assets/icons/svg_unselected_seat.svg';
      }
    case SeatState.selected:
      {
        return 'assets/icons/svg_selected_seats.svg';
      }
    case SeatState.disabled:
      {
        return 'assets/icons/svg_disabled_seat.svg';
      }
    case SeatState.sold:
      {
        return 'assets/icons/svg_sold_seat.svg';
      }
    case SeatState.empty:
    default:
      {
        return 'assets/icons/svg_disabled_seat.svg';
      }
  }
}
