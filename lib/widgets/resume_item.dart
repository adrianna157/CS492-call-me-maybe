import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/resume.dart';

class ResumeItem extends StatefulWidget {
  @override
  _ResumeItem createState() => _ResumeItem();
}

class _ResumeItem extends State<ResumeItem> {
  @override
  Widget build(BuildContext context) {
    // retrieving providers objects
    final resume = Provider.of<Resume>(context, listen: false);

    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 3),
                child: Row(
                  children: <Widget>[
                    Text(
                      resume.jobName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 3, 0, 3),
                child: Row(
                  children: <Widget>[
                    Text(
                      resume.company,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        resume.duration,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        resume.location,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 3, 0, 3),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Text(
                        resume.description,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        maxLines: 3,
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
}