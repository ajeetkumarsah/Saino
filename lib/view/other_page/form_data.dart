import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saino/db/firebase_repository.dart';
import 'package:saino/main.dart';
import 'package:saino/model/form_data.dart';
import 'package:saino/widgets/custom_appbar.dart';
import 'package:saino/widgets/custom_textform.dart';

class FormData extends StatelessWidget {
  static const routeName = '/FormData';
  const FormData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainContainer();
  }
}

class MainContainer extends StatefulWidget {
  const MainContainer({Key? key}) : super(key: key);

  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  OurFormDataModel ourdataModel = new OurFormDataModel();
  final _formKey = GlobalKey<FormState>();
  String? contactNumber, selectedCountry, firstName, lastName, gender;
  bool _isUploading = false;
  BuildContext? scaffoldContext;
  List<String> countries = [
    'India',
    'USA',
    'China',
  ];
  Object? _radioSelected = 1;

  String? _radioVal = 'Male';
  get radioVal => this._radioVal;

  set radioVal(value) => this._radioVal = value;
  Object? get radioSelected => this._radioSelected;

  set radioSelected(Object? value) => this._radioSelected = value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Upload Data',
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CustomTextFormField(
                        hintText: 'Your first name',
                        onChanged: (val) {
                          firstName = val;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'First name is empty';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        hintText: 'Your last name',
                        onChanged: (val) {
                          lastName = val;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Last name is empty';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        hintText: 'Phone Number',
                        isNumber: true,
                        onChanged: (val) {
                          contactNumber = val;
                          setState(() => _formKey.currentState!.validate());
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Contact Number is empty';
                          } else if (text.length < 10 || text.length > 10) {
                            return 'Contact Number is correct';
                          }
                          return null;
                        },
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1.5,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: DropdownButton<String>(
                              hint: Text('Select Country*'),
                              value: selectedCountry,
                              isExpanded: true,
                              items: countries.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (r) {
                                setState(() {
                                  selectedCountry = r;
                                  print(r);
                                });
                              },
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18),
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 1,
                    groupValue: radioSelected,
                    activeColor: green,
                    onChanged: (value) {
                      setState(() {
                        radioSelected = value;
                        radioVal = 'Male';
                      });
                    },
                  ),
                  const Text('Male'),
                  new Radio(
                    value: 2,
                    groupValue: radioSelected,
                    activeColor: green,
                    onChanged: (value) {
                      setState(() {
                        radioSelected = value;
                        radioVal = 'Female';
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _isUploading
            ? CupertinoActivityIndicator()
            : FloatingActionButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      selectedCountry != null) {
                    setState(() {
                      _isUploading = true;
                    });
                    addNewData(firstName!, lastName!, contactNumber!, radioVal,
                        selectedCountry!);
                    setState(() {
                      _isUploading = false;
                    });
                  } else
                    createSnackBar('Please provide all the Data');
                },
                child: Center(
                  child: Icon(Icons.upload),
                ),
              ));
  }

  void addNewData(String fName, String lName, String number, String gender,
      String country) async {
    bool result = await firebaseRepository.addNewTrucks(
        map: addData(
      fName,
      lName,
      number,
      gender,
      country,
    ));
    if (result) {
      Navigator.pop(context);
    } else {}
  }

  Map<String, dynamic> addData(String? fName, String? lName, String? number,
      String? gender, String country) {
    ourdataModel.fName = fName;
    ourdataModel.lName = lName;
    ourdataModel.number = number;
    ourdataModel.gender = gender;
    ourdataModel.country = country;

    return OurFormDataModel().convertToMap(value: ourdataModel);
  }

  void createSnackBar(String message) {
    final snackBar =
        new SnackBar(content: new Text(message), backgroundColor: Colors.red);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    Scaffold.of(scaffoldContext!).showSnackBar(snackBar);
  }
}
