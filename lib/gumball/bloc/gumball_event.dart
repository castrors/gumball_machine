part of 'gumball_bloc.dart';

sealed class GumballEvent {
  const GumballEvent();
}

class InsertCoin extends GumballEvent {
  const InsertCoin();
}

class TurnHandle extends GumballEvent {
  const TurnHandle();
}

class RemoveCoin extends GumballEvent {
  const RemoveCoin();
}
