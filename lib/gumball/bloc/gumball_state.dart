part of 'gumball_bloc.dart';

enum GumballStatus { locked, unlocked }

class GumballState extends Equatable {
  const GumballState({
    required this.status,
    this.message = 'Insert Coin',
    this.count = 3,
  });

  final GumballStatus status;
  final String message;
  final int count;

  const GumballState.initial() : this(status: GumballStatus.locked);

  @override
  List<Object?> get props => [status, message, count];

  GumballState copyWith({
    GumballStatus? status,
    String? message,
    int? count,
  }) {
    return GumballState(
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}
