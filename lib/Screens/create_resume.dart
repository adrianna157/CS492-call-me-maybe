import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/resume.dart';

import '../models/resume.dart';
import '../models/resume_provider.dart';

class CreateResumeScreen extends StatefulWidget {
  static const routeName = '/create-new-resume';

  @override
  _CreateResumeScreen createState() => _CreateResumeScreen();
}

class _CreateResumeScreen extends State<CreateResumeScreen> {
  final _jobNameFocusNode = FocusNode();
  final _companyFocusNode = FocusNode();
  final _durationFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  final _jobNameController = TextEditingController();
  final _companyController = TextEditingController();
  final _durationController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  // global key
  final _form = GlobalKey<FormState>();

  // update this edited product when save form
  var _editedResume = Resume(
    id: null,
    jobName: '',
    company: '',
    duration: '',
    location: '',
    description: '',
  );

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });

      // retrieve major data from FB
      Provider.of<Resumes>(context).retrieveResumeData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  var currentSelectedValue;
  var currentSelectedValue3;

  var _isLoading = false;

  // save form data by using grobal key
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();

    // error handling for the form value
    if (!isValid) {
      return;
    }

    // only if the form is valid, save the result
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Resumes>(context, listen: false)
          .addResume(_editedResume);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occured!'),
                content: Text('Some error occured while adding review'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                  ),
                ],
              ));
    }

    setState(() {
      _isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResumeScreen(),
      ),
    );

    // pop up message when course successfully added
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('New activity'),
        content: Text('New Resume has been created'),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
          ),
        ],
      ),
    );
    _form.currentState?.reset();
  }

  @override
  void dispose() {
    // avoid momery leaks
    _jobNameFocusNode.dispose();
    _companyFocusNode.dispose();
    _durationFocusNode.dispose();
    _locationFocusNode.dispose();
    _descriptionFocusNode.dispose();

    _jobNameController.dispose();
    _companyController.dispose();
    _durationFocusNode.dispose();
    _locationFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final resumeList = Provider.of<Resumes>(context);
    final resumes = resumeList.resumes;

    return Scaffold(
      appBar: AppBar(
        title: Text('University Course Search'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            // setting global key in the form
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'Create New Resume',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      controller: _jobNameController,
                      decoration: InputDecoration(
                        labelText: 'Resume name',
                        suffixIcon: IconButton(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.clear,
                              size: 18,
                            ),
                          ),
                          onPressed: () {
                            _jobNameController.clear();
                          },
                        ),
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      focusNode: _jobNameFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a resume name.';
                        } else {
                          return null; // no error
                        }
                      },
                      onSaved: (value) {
                        _editedResume = Resume(
                          id: _editedResume.id,
                          jobName: value,
                          company: _editedResume.company,
                          duration: _editedResume.duration,
                          location: _editedResume.location,
                          description: _editedResume.description,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      controller: _companyController,
                      decoration: InputDecoration(
                        labelText: 'Company',
                        suffixIcon: IconButton(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.clear,
                              size: 18,
                            ),
                          ),
                          onPressed: () {
                            _companyController.clear();
                          },
                        ),
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      focusNode: _companyFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a company name.';
                        } else {
                          return null; // no error
                        }
                      },
                      onSaved: (value) {
                        _editedResume = Resume(
                          id: _editedResume.id,
                          jobName: _editedResume.jobName,
                          company: value,
                          duration: _editedResume.duration,
                          location: _editedResume.location,
                          description: _editedResume.description,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      controller: _durationController,
                      decoration: InputDecoration(
                        labelText: 'Duration',
                        suffixIcon: IconButton(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.clear,
                              size: 18,
                            ),
                          ),
                          onPressed: () {
                            _durationController.clear();
                          },
                        ),
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      focusNode: _durationFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a resume name.';
                        } else {
                          return null; // no error
                        }
                      },
                      onSaved: (value) {
                        _editedResume = Resume(
                          id: _editedResume.id,
                          jobName: _editedResume.jobName,
                          company: _editedResume.company,
                          duration: value,
                          location: _editedResume.location,
                          description: _editedResume.description,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        suffixIcon: IconButton(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.clear,
                              size: 18,
                            ),
                          ),
                          onPressed: () {
                            _locationController.clear();
                          },
                        ),
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      focusNode: _locationFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a resume name.';
                        } else {
                          return null; // no error
                        }
                      },
                      onSaved: (value) {
                        _editedResume = Resume(
                          id: _editedResume.id,
                          jobName: _editedResume.jobName,
                          company: _editedResume.company,
                          duration: _editedResume.duration,
                          location: value,
                          description: _editedResume.description,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        suffixIcon: IconButton(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              Icons.clear,
                              size: 18,
                            ),
                          ),
                          onPressed: () {
                            _descriptionController.clear();
                          },
                        ),
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a resume name.';
                        } else {
                          return null; // no error
                        }
                      },
                      onSaved: (value) {
                        _editedResume = Resume(
                          id: _editedResume.id,
                          jobName: _editedResume.jobName,
                          company: _editedResume.company,
                          duration: _editedResume.duration,
                          location: _editedResume.location,
                          description: value,
                        );
                      },
                    ),
                  ),

                  // Raised Button
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      child: RaisedButton(
                        onPressed: _saveForm,
                        child: Text(
                          "Save Resume",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}