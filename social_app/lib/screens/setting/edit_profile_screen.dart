import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_app/utilities/style_constants.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? _genderRadioBtnVal;
  DateTime _birthday = DateTime(2000, 01, 25);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: cointainerColor,
          title: const Text(
            'Edit profile',
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKBBd2Tr8_Q46N9Poo76Syy-JeZrXO4r1t-A&usqp=CAU"),),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("lib/assets/avatar.jpg"),
                      radius: 30,
                    ),
                  ),
                ],
              ),
              _inputForm(title: "Name", initValue: "ldlong"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gender",
                      style: kLabelStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: [
                            Radio<String>(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              value: "Male",
                              groupValue: _genderRadioBtnVal,
                              onChanged: (value) {
                                _handleGenderChange(value!);
                              },
                            ),
                            const Text(
                              "Male",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              value: "Female",
                              groupValue: _genderRadioBtnVal,
                              onChanged: (value) {
                                _handleGenderChange(value!);
                              },
                            ),
                            const Text(
                              "Female",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.white),
                              value: "Other",
                              groupValue: _genderRadioBtnVal,
                              onChanged: (value) {
                                _handleGenderChange(value!);
                              },
                            ),
                            const Text(
                              "Other",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Date of birth",
                      style: kLabelStyle,
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(_birthday),
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() async {
                              _birthday = (await showDatePicker(
                                context: context,
                                initialDate: _birthday,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.dark().copyWith(
                                      colorScheme: ColorScheme.dark(
                                        primary: Colors.deepPurple,
                                        onPrimary: Colors.white,
                                        surface: cointainerColor,
                                        onSurface: Colors.yellow,
                                      ),
                                      dialogBackgroundColor: backGroundColor,
                                    ),
                                    child: child!,
                                  );
                                },
                              ))!;
                            });
                          },
                          icon: Icon(Icons.calendar_today),
                          color: Colors.white,
                          iconSize: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _inputForm(
                  title: "Descrpition",
                  initValue:
                      "boy co don tim girl dasdasdasdasdasdasdasdasdasdasdasdasdasdas"),
              _inputForm(title: 'Address', initValue: 'Hai Ba Trung'),
              _inputForm(title: 'City', initValue: 'Ha Noi'),
              _inputForm(title: 'Country', initValue: 'Viet Nam'),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Cancel', style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Save', style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  void _handleGenderChange(String value) {
    setState(() {
      _genderRadioBtnVal = value;
    });
  }

  Widget _inputForm({
    required String title,
    required String initValue,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: kLabelStyle,
          ),
          const SizedBox(height: 10.0),
          Form(
            child: TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              initialValue: initValue,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                  errorStyle: kErrorStyle,
                  fillColor: Colors.white24,
                  filled: true,
                  hintStyle: kHintTextStyle,
                  contentPadding: const EdgeInsets.fromLTRB(10, 14, 10, 0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
