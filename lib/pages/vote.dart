import 'package:flutter/material.dart';

class vote extends StatefulWidget {
  const vote({Key? key}) : super(key: key);

  @override
  State<vote> createState() => _voteState();
}

class _voteState extends State<vote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลโหวต'),
        leading: BackButton(color: Colors.white60),
        backgroundColor: Colors.indigo,

      ),
    );
  }
}
