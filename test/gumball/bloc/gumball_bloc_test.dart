import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gumball_machine/gumball/bloc/gumball_bloc.dart';

void main() {
  group('GumballBloc', () {
    late GumballBloc gumballBloc;

    setUp(() {
      gumballBloc = GumballBloc();
    });

    tearDown(() {
      gumballBloc.close();
    });

    test('initial state is locked and message is Insert Coin and count is 10',
        () {
      expect(gumballBloc.state,
          equals(const GumballState(status: GumballStatus.locked)));
      expect(gumballBloc.state.message, equals('Insert Coin'));
      expect(gumballBloc.state.count, equals(3));
    });

    blocTest<GumballBloc, GumballState>(
      'emits unlocked state when coin is inserted',
      build: () => gumballBloc,
      act: (bloc) => bloc.add(const InsertCoin()),
      expect: () => [
        const GumballState(
          status: GumballStatus.unlocked,
          message: 'Turn to get a gumball',
        )
      ],
    );

    blocTest<GumballBloc, GumballState>(
      'emits unlocked state when coin is inserted and then locked state when turn is completed',
      build: () => gumballBloc,
      act: (bloc) => bloc
        ..add(const InsertCoin())
        ..add(const TurnHandle()),
      expect: () => [
        const GumballState(
          status: GumballStatus.unlocked,
          message: 'Turn to get a gumball',
        ),
        const GumballState(
          status: GumballStatus.locked,
          message: 'Insert Coin',
          count: 2,
        )
      ],
    );

    blocTest<GumballBloc, GumballState>(
      'emits unlocked state when coin is inserted and then locked state when remove coin is completed',
      build: () => gumballBloc,
      act: (bloc) => bloc.add(const RemoveCoin()),
      expect: () => [
        const GumballState(
          status: GumballStatus.locked,
          message: 'No coin found, please insert coin',
          count: 3,
        ),
      ],
    );

    blocTest<GumballBloc, GumballState>(
      'emits unlocked state when coin is inserted and then locked state when remove coin is completed',
      build: () => gumballBloc,
      act: (bloc) => bloc
        ..add(const InsertCoin())
        ..add(const RemoveCoin()),
      expect: () => [
        const GumballState(
          status: GumballStatus.unlocked,
          message: 'Turn to get a gumball',
        ),
        const GumballState(
          status: GumballStatus.locked,
          message: 'Insert Coin',
          count: 3,
        ),
      ],
    );

    blocTest<GumballBloc, GumballState>(
      'emits unlocked state when coin is inserted and then locked state when turn is completed',
      build: () => gumballBloc,
      act: (bloc) => bloc
        ..add(const InsertCoin())
        ..add(const TurnHandle())
        ..add(const TurnHandle()),
      expect: () => [
        const GumballState(
          status: GumballStatus.unlocked,
          message: 'Turn to get a gumball',
        ),
        const GumballState(
          status: GumballStatus.locked,
          message: 'Insert Coin',
          count: 2,
        ),
        const GumballState(
          status: GumballStatus.locked,
          message: 'No coin found, please insert coin',
          count: 2,
        )
      ],
    );

    blocTest<GumballBloc, GumballState>(
      'emits unlocked state when coin is inserted and then locked state when turn is completed',
      build: () => gumballBloc,
      act: (bloc) => bloc
        ..add(const InsertCoin())
        ..add(const TurnHandle())
        ..add(const InsertCoin())
        ..add(const TurnHandle()),
      expect: () => [
        const GumballState(
          status: GumballStatus.unlocked,
          message: 'Turn to get a gumball',
        ),
        const GumballState(
          status: GumballStatus.locked,
          message: 'Insert Coin',
          count: 2,
        ),
        const GumballState(
          status: GumballStatus.unlocked,
          message: 'Turn to get a gumball',
          count: 2,
        ),
        const GumballState(
          status: GumballStatus.locked,
          message: 'Insert Coin',
          count: 1,
        )
      ],
    );

    blocTest<GumballBloc, GumballState>(
      'emits unlocked state when coin is inserted and then keeps unlocked state when user tries to add other coin',
      build: () => gumballBloc,
      act: (bloc) => bloc
        ..add(const InsertCoin())
        ..add(const InsertCoin()),
      expect: () => [
        const GumballState(
          status: GumballStatus.unlocked,
          message: 'Turn to get a gumball',
        ),
        const GumballState(
          status: GumballStatus.unlocked,
          message:
              'Coin already inserted, please turn the handle to get a gumball',
        )
      ],
    );

    blocTest<GumballBloc, GumballState>(
      'emits unlocked state when coin is inserted and then locked state when turn is completed',
      build: () => gumballBloc,
      act: (bloc) => bloc
        ..add(const InsertCoin())
        ..add(const TurnHandle())
        ..add(const InsertCoin())
        ..add(const TurnHandle())
        ..add(const InsertCoin())
        ..add(const TurnHandle())
        ..add(const InsertCoin()),
      expect: () => [
        const GumballState(
          status: GumballStatus.unlocked,
          message: 'Turn to get a gumball',
        ),
        const GumballState(
          status: GumballStatus.locked,
          message: 'Insert Coin',
          count: 2,
        ),
        const GumballState(
          status: GumballStatus.unlocked,
          message: 'Turn to get a gumball',
          count: 2,
        ),
        const GumballState(
          status: GumballStatus.locked,
          message: 'Insert Coin',
          count: 1,
        ),
        const GumballState(
          status: GumballStatus.unlocked,
          message: 'Turn to get a gumball',
          count: 1,
        ),
        const GumballState(
          status: GumballStatus.locked,
          message: 'Out of gumballs',
          count: 0,
        ),
        const GumballState(
          status: GumballStatus.locked,
          message: 'Out of gumballs, no coin accepted',
          count: 0,
        ),
      ],
    );
  });
}
