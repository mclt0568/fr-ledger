import 'dart:async';

class ProgressBarControl {
  ProgressBarControl(double value) {
    _value = value;
  }

  double _value = 0;
  double get value => _value;
  StreamController<double> updateStream = StreamController<double>();

  void updateValue(double newValue) {
    assert(newValue < 1 && newValue > 0);
    updateStream.add(newValue);
    _value = newValue;
  }

  void registerListener(void Function(double) listener) {
    updateStream.stream.listen(listener);
  }

  void cleanup() {
    updateStream = StreamController<double>();
  }
}
