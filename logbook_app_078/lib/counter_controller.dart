class CounterController {
  int _counter = 0;
  int _step = 1; // Variabel Step

  int get value => _counter;
  int get step => _step;

  void setStep(int newStep) {
    _step = newStep;
  }

  void increment() {
    _counter += _step; // Tambah sesuai step
  }

  void decrement() {
    if (_counter >= _step) {
      _counter -= _step; // Kurang sesuai step
    } else {
      _counter = 0;
    }
  }

  void reset() {
    _counter = 0;
  }
}