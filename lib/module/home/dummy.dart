import 'package:flutter/material.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const DummyPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DummyPage'),
      ),
      body: const Center(
        child: Text('DummyPage'),
      ),
    );
  }
}
