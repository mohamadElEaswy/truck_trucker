import 'package:flutter/material.dart';

class StartShipmentPage extends StatefulWidget {
  const StartShipmentPage({Key? key}) : super(key: key);

  @override
  State<StartShipmentPage> createState() => _StartShipmentPageState();
}

class _StartShipmentPageState extends State<StartShipmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('StartShipmentPage'),
      ),
    );
  }
}
