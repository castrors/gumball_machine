import 'package:flutter_test/flutter_test.dart';
import 'package:gumball_machine/gumball/bloc/gumball_bloc.dart';

void main() {
  group('GumballState', () {
    test('copyWith test all fields', () async {
      // Given
      const state = GumballState(
        status: GumballStatus.locked,
        message: 'Insert Coin',
        count: 3,
      );

      // When
      final newState = state.copyWith(
        status: GumballStatus.unlocked,
        message: 'Turn to get a gumball',
        count: 2,
      );

      // Then
      expect(newState.status, equals(GumballStatus.unlocked));
      expect(newState.message, equals('Turn to get a gumball'));
      expect(newState.count, equals(2));
    });

    test('copyWith test only status field', () async {
      // Given
      const state = GumballState(
        status: GumballStatus.locked,
        message: 'Insert Coin',
        count: 3,
      );

      // When
      final newState = state.copyWith(
        status: GumballStatus.unlocked,
      );

      // Then
      expect(newState.status, equals(GumballStatus.unlocked));
      expect(newState.message, equals('Insert Coin'));
      expect(newState.count, equals(3));
    });

    test('copyWith test only message field', () async {
      // Given
      const state = GumballState(
        status: GumballStatus.locked,
        message: 'Insert Coin',
        count: 3,
      );

      // When
      final newState = state.copyWith(
        message: 'Turn to get a gumball',
      );

      // Then
      expect(newState.status, equals(GumballStatus.locked));
      expect(newState.message, equals('Turn to get a gumball'));
      expect(newState.count, equals(3));
    });

    test('copyWith test only count field', () async {
      // Given
      const state = GumballState(
        status: GumballStatus.locked,
        message: 'Insert Coin',
        count: 3,
      );

      // When
      final newState = state.copyWith(
        count: 2,
      );

      // Then
      expect(newState.status, equals(GumballStatus.locked));
      expect(newState.message, equals('Insert Coin'));
      expect(newState.count, equals(2));
    });
  });
}
