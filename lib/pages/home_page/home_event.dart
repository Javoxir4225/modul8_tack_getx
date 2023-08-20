abstract class HomeEvent {}

class FetchQuranEvent extends HomeEvent {
  FetchQuranEvent();
}

class OnpressedEvent extends HomeEvent {
  OnpressedEvent();
}

class OnpressedEmptyEvent extends HomeEvent {
  OnpressedEmptyEvent();
}

class OnpressedSearchEvent extends HomeEvent {
  final String value;
  OnpressedSearchEvent({required this.value});
}
