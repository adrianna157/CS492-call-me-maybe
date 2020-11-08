
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessCardScreen extends StatefulWidget {
  static const routeName = '/business-card-screen';

  @override
  _BusinessCardScreen createState() => _BusinessCardScreen();
}

class _BusinessCardScreen extends State<BusinessCardScreen> {
  final name = 'Adrianna Guevarra';
  final job = 'Computer Science Student';
  final phone = '(580) 695-4831';
  final github = 'https://github.com/adrianna157';
  final email = 'guevarra@oregonstate.edu';

  @override
  Widget build(BuildContext context) {
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
                padding:  EdgeInsets.all(padding(context)),
                child: Icon(
                  Icons.email,
                  color: Colors.grey,
                  size: 100,
                ),
              ),
              Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(padding(context)),
                child: Center(
                  child: Text(
                    job,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: _launchSMS,
                      child: Padding(
                        padding:  EdgeInsets.all(padding(context)),
                        child: Text(
                          phone,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: _launchURL,
                      child: Padding(
                        padding:  EdgeInsets.all(padding(context)),
                        child: Text(
                          github,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _sendEmail,
                      child: Padding(
                        padding:  EdgeInsets.all(padding(context)),
                        child: Text(
                          email,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = "https://github.com/adrianna157";
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Could not Launch $url';
    }
  }

  _launchSMS() async {
    const url = 'sms:5806954831';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Could not Launch $url';
    }
  }

  _sendEmail() async {
    var url = 'mailto:guevarra@oregonstate.edu';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Could not Launch $url';
    }
  }

  double padding(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.width * 0;
    } else {
      return MediaQuery.of(context).size.width * 0.01;
    }
  }
}
