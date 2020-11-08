import 'package:flutter/material.dart';

class ContactMeScreen extends StatefulWidget {
  static const routeName = '/business-card-screen';

  @override
  _ContactMeScreen createState() => _ContactMeScreen();
}

class _ContactMeScreen extends State<ContactMeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      if (_counter != 3) {
        _counter++;
      } else {
        _counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> text = [
      'Yes, Definitely',
      'Unlikely but possible',
      'Maybe indeed',
      'The future is uncertain'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Call me maybe'),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Icon(
                  Icons.phone,
                  color: Colors.grey,
                  size: 100,
                ),
              ),
              Center(
                child: Text(
                  'Call me... Maybe?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(padding(context)),
                  child: Center(
                    child: InkWell(
                      onTap: _incrementCounter,
                      child: Text(
                        'Ask question... tap for the answer.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  text[_counter],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  double padding(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.width * 0;
    } else {
      return MediaQuery.of(context).size.width * 0.01;
    }
  }
}

