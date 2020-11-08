import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // for http request
import './resume.dart';

class Resumes with ChangeNotifier {
  List<Resume> _resumes = [];

  // getter for resume
  List<Resume> get resumes {
    return [..._resumes];
  }

  //Comparing ID of each courses with id of the arguments
  Resume findById(String id) {
    return _resumes.firstWhere((rs) => rs.id == id);
  }

  Future<void> retrieveResumeData() async {
    const url = 'https://raw.githubusercontent.com/adrianna157/adrianna157.github.io/master/resume_items.json';
    try {
      final response = await http.get(url); // get for fetching from DB
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      final List<Resume> loadedResumes = [];

      extractedData.forEach((resumeId, resumeData) {
        loadedResumes.add(Resume(
          id: resumeId,
          jobName: resumeData['jobName'],
          company: resumeData['company'],
          duration: resumeData['duration'],
          location: resumeData['location'],
          description: resumeData['description'],
        ));
      });
      _resumes = loadedResumes;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addResume(Resume resume) async {
    const url = 'https://raw.githubusercontent.com/adrianna157/adrianna157.github.io/master/resume_items.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'jobName': resume.jobName,
          'company': resume.company,
          'duration': resume.duration,
          'location': resume.location,
          'description': resume.description,
        }),
      );

      final newResume = Resume(
        jobName: resume.jobName,
        company: resume.company,
        duration: resume.duration,
        location: resume.location,
        description: resume.location,
        id: json.decode(response.body)['name'],
      );
      _resumes.add(newResume);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}