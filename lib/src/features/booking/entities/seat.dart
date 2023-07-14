enum SeatState {
  selected,

  unselected,

  sold,

  disabled,

  empty,
}

class SeatModel {
  final SeatState seatState;
  final int rowI;
  final int colI;
  final int seatSvgSize;
  final String pathSelectedSeat;
  final String pathUnSelectedSeat;
  final String pathSoldSeat;
  final String pathDisabledSeat;

  const SeatModel({
    required this.seatState,
    required this.rowI,
    required this.colI,
    this.seatSvgSize = 50,
    required this.pathSelectedSeat,
    required this.pathDisabledSeat,
    required this.pathSoldSeat,
    required this.pathUnSelectedSeat,
  });
}
