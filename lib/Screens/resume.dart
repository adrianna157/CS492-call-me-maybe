import 'package:guevarra_adrianna/screens/create_resume.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/resume_provider.dart';
import '../widgets/resume_item.dart';

class ResumeScreen extends StatefulWidget {
  static const routeName = '/business-card-screen';

  @override
  _ResumeScreen createState() => _ResumeScreen();
}

class _ResumeScreen extends State<ResumeScreen> {
  final name = 'Adrianna Guevarra';
  final email = 'guevarra@oregonstate.edu';
  final github = 'https://github.com/adrianna157';
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Resumes>(context).retrieveResumeData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  Widget _buildRowWithPadding(String text) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowForLaunchUrl(String text) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: InkWell(
              onTap: _launchURL,
              child: Text(
                github,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loadedResumes = Provider.of<Resumes>(context);
    final resumes = loadedResumes.resumes;

    return Scaffold(
      appBar: AppBar(
        title: Text('Call me maybe'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _buildRowWithPadding(name),
                        _buildRowWithPadding(email),
                        _buildRowForLaunchUrl(github),
                        Flexible(
                          child: new ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            itemCount: resumes.length,
                            itemBuilder: (ctx, i) =>
                                ChangeNotifierProvider.value(
                              value: resumes[i],
                              child: ResumeItem(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateResumeScreen(),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = "https://github.com/adrianna157";
  if (await canLaunch(url)) {
    launch(url);
  } else {
    throw 'Could not Launch $url';
  }
}