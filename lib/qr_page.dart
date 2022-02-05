import 'package:flutter/material.dart';

class qrscan extends StatefulWidget {
  const qrscan({Key? key}) : super(key: key);

  @override
  _qrscanState createState() => _qrscanState();
}

class _qrscanState extends State<qrscan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.camera),
        label: Text('scan'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
