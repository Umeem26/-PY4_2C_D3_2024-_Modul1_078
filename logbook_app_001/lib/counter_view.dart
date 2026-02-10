import 'package:flutter/material.dart';
import 'counter_controller.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();

  void refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 1: Multi-Step")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Atur Langkah (Step):"),
            Slider(
              value: _controller.step.toDouble(),
              min: 1, max: 10, divisions: 9,
              label: _controller.step.toString(),
              onChanged: (val) {
                _controller.setStep(val.toInt());
                refresh();
              },
            ),
            Text('${_controller.value}', style: const TextStyle(fontSize: 50)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () { _controller.decrement(); refresh(); }, child: const Text("-")),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: () { _controller.increment(); refresh(); }, child: const Text("+")),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { _controller.reset(); refresh(); },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}