import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gumball_event.dart';
part 'gumball_state.dart';

class GumballBloc extends Bloc<GumballEvent, GumballState> {
  GumballBloc() : super(const GumballState.initial()) {
    on<InsertCoin>(_onCoinInserted);
    on<TurnHandle>(_onTurnHandle);
    on<RemoveCoin>(_onRemoveCoin);
  }

  void _onCoinInserted(InsertCoin event, Emitter<GumballState> emit) {
    if (state.count == 0) {
      emit(state.copyWith(
        status: GumballStatus.locked,
        message: 'Out of gumballs, no coin accepted',
      ));
    } else if (state.status == GumballStatus.unlocked) {
      emit(state.copyWith(
        status: GumballStatus.unlocked,
        message:
            'Coin already inserted, please turn the handle to get a gumball',
      ));
    } else {
      emit(state.copyWith(
        status: GumballStatus.unlocked,
        message: 'Turn to get a gumball',
      ));
    }
  }

  void _onTurnHandle(TurnHandle event, Emitter<GumballState> emit) {
    if (state.status == GumballStatus.unlocked) {
      if (state.count == 1) {
        emit(state.copyWith(
          status: GumballStatus.locked,
          message: 'Out of gumballs',
          count: state.count - 1,
        ));
      } else {
        emit(state.copyWith(
          status: GumballStatus.locked,
          message: 'Insert Coin',
          count: state.count - 1,
        ));
      }
    } else {
      emit(state.copyWith(
        status: GumballStatus.locked,
        message: 'No coin found, please insert coin',
        count: state.count,
      ));
    }
  }

  void _onRemoveCoin(RemoveCoin event, Emitter<GumballState> emit) {
    if (state.status == GumballStatus.unlocked) {
      emit(state.copyWith(
        status: GumballStatus.locked,
        message: 'Insert Coin',
      ));
    } else {
      emit(state.copyWith(
        status: GumballStatus.locked,
        message: 'No coin found, please insert coin',
      ));
    }
  }
}
