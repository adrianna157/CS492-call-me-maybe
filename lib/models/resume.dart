import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Resume with ChangeNotifier {
  final String id;
  final String jobName;
  final String company;
  final String duration;
  final String location;
  final String description;

  Resume({
    @required this.id,
    @required this.jobName,
    @required this.company,
    @required this.duration,
    @required this.location,
    @required this.description,
  });
}