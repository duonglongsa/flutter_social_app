import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_app/controllers/setting/edit_profile_controller.dart';
import 'package:social_app/utilities/configs.dart';
import 'package:social_app/utilities/style_constants.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
    editProfileController.getUserInfo();
  }

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
        body: Center(
          child: SingleChildScrollView(
            child: GetBuilder(
                init: editProfileController,
                builder: (_) {
                  if (editProfileController.user == null) {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      Stack(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                                child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Image.network(
                                        "$networkFile${editProfileController.user!.coverImage!.fileName}"))),
                            const SizedBox(
                              height: 60,
                            )
                          ],
                        ),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                  "$networkFile${editProfileController.user!.avatar!.fileName}"),
                            ),
                          ),
                        ))
                      ]),
                      _inputForm(
                          title: "Name",
                          initValue: editProfileController.user!.name!),
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
                                      value: "male",
                                      groupValue:
                                          editProfileController.user!.gender!,
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
                                      value: "female",
                                      groupValue:
                                          editProfileController.user!.gender!,
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
                                      value: "secret",
                                      groupValue:
                                          editProfileController.user!.gender!,
                                      onChanged: (value) {
                                        _handleGenderChange(value!);
                                      },
                                    ),
                                    const Text(
                                      "Secret",
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
                                  editProfileController.user!.birthDay != null
                                      ? DateFormat('dd/MM/yyyy').format(
                                          editProfileController.user!.birthDay!)
                                      : '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    editProfileController.setBirthDay(context);
                                  },
                                  icon: const Icon(Icons.calendar_today),
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
                              editProfileController.user!.description ?? ''),
                      _inputForm(
                          title: 'Address',
                          initValue: editProfileController.user!.address ?? ''),
                      _inputForm(
                          title: 'City',
                          initValue: editProfileController.user!.city ?? ''),
                      _inputForm(
                          title: 'Country',
                          initValue: editProfileController.user!.country ?? ''),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                          )
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ));
  }

  void _handleGenderChange(String value) {
    setState(() {
      editProfileController.user!.gender = value;
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
