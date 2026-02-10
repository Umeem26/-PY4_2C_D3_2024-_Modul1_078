class CounterController {
  int _counter = 0;
  int _step = 1;
  final List<String> _history = [];

  int get value => _counter;
  int get step => _step;
  List<String> get history => _history;

  void _addHistory(String message) {
    _history.insert(0, message);
    if (_history.length > 5) {
      _history.removeLast();
    }
  }

  void setStep(int newStep) => _step = newStep;

  void increment() {
    _counter += _step;
    _addHistory("Ditambah $_step (Total: $_counter)");
  }

  void decrement() {
    if (_counter >= _step) {
      _counter -= _step;
      _addHistory("Dikurang $_step (Total: $_counter)");
    } else {
      _counter = 0;
      _addHistory("Dikurang mentok ke 0");
    }
  }

  void reset() {
    _counter = 0;
    _addHistory("Data di-reset ke 0");
  }
}