import 'dart:convert';

import 'package:election_2566_poll/models/choices.dart';
import 'package:flutter/material.dart';

import '../../models/DataList.dart';
import '../../models/poll.dart';
import '../../models/response_body.dart';
import '../my_scaffold.dart';
import 'package:http/http.dart' as http;

import '../vote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Poll>? _polls;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/api/polls');
    var response = await http.get(url); // ตัวแปรเก็บดึงค่า

    setState(() {
      _isLoading = false; //ดึงค่าเสร็จ
    });

    var json = jsonDecode(response.body); //ค่าที่ได้จาก
    var Response = ResponseBody.fromJson(json);
    var dataModel;
    for (var element in Response.data) {
      dataModel = Poll.fromJson(element);
      Datalist1.list.add(dataModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          Image.network(
              'https://cpsu-test-api.herokuapp.com/images/election.jpg'),
          Expanded(
            child: Stack(
              children: [
                if (_polls != null) _buildList(),
                if (_isLoading) _buildProgress(),
                ListView.builder(
                  itemCount: Datalist1.list.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, index),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    var Item = Datalist1.list[index];
    return Container(
      width: 200,
      height: 300,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Item.question,style: TextStyle(fontSize: 16,),),
          ),
          Text(Item.)
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => new vote()));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'ดูผลโหวต',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );

  }

  ListView _buildList() {
    return ListView.builder(
      itemCount: _polls!.length,
      itemBuilder: (BuildContext context, int index) {
        // todo: Create your poll item by replacing this Container()
        return Container(
          width: 200,
          height: 300,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: const Text('XXXX'),
        );
      },
    );
  }

  Widget _buildProgress() {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(color: Colors.white),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('รอสักครู่', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
