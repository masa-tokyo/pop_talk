import 'dart:async';

typedef OnFiredEvent<T extends Event> = void Function(T event);

class EventPublisher {
  factory EventPublisher() {
    return _instance ??= EventPublisher._internal();
  }

  EventPublisher._internal();

  static EventPublisher? _instance;

  final Map<Type, StreamController<Event>> _controllers = {};

  void publish<T extends Event>(T event) {
    _getController<T>().sink.add(event);
  }

  StreamSubscription<T> listen<T extends Event>(
    OnFiredEvent<T> onFiredEvent,
  ) {
    return _getController<T>().stream.listen(onFiredEvent);
  }

  StreamController<T> _getController<T extends Event>() {
    if (_controllers[T] != null) {
      return _controllers[T]! as StreamController<T>;
    }
    return _controllers[T] = StreamController<T>.broadcast();
  }
}

abstract class Event {}
