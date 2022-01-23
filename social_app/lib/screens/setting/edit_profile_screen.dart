import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:social_app/controllers/setting/edit_profile_controller.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/utilities/configs.dart';
import 'package:social_app/utilities/style_constants.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);
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
    editProfileController.user = widget.user;
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
        body: GetBuilder(
          init: editProfileController,
          builder: (_) {
            return LoadingOverlay(
              isLoading: editProfileController.isLoading,
              child: Center(
                child: SingleChildScrollView(
                  child: GetBuilder(
                      init: editProfileController,
                      builder: (_) {
                        if (editProfileController.user == null) {
                          return const CircularProgressIndicator();
                        }
                        return Form(
                          key: editProfileController.formKey,
                          child: Column(
                            children: [
                              Stack(children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Stack(
                                      children: [
                                        FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: editProfileController
                                                        .coverImagePath ==
                                                    null
                                                ? Image.network(
                                                    "$networkFile${editProfileController.user!.coverImage!.fileName}")
                                                : Image.file(editProfileController
                                                    .coverImagePath!)),
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: FlatButton(
                                              onPressed: () async {
                                                editProfileController.pickImage(context, false);
                                              },
                                              child: const Icon(
                                                Icons.camera_alt,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                              shape: const CircleBorder(),
                                              color: Colors.black12,
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    )
                                  ],
                                ),
                                Positioned.fill(
                                    child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 65,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 60,
                                          backgroundImage: editProfileController.avatarPath == null 
                                          ? NetworkImage(
                                              "$networkFile${editProfileController.user!.avatar!.fileName}") 
                                          : FileImage(editProfileController.avatarPath!) as ImageProvider,
                                        ),
                                      ),
                                      Positioned(
                                        left: 60,
                                        top: 80,
                                        child: FlatButton(
                                          onPressed: () async {
                                            editProfileController.pickImage(context, true);
                                          },
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 20
                                          ),
                                          shape: const CircleBorder(),
                                          color: Colors.black12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                              ]),
                              _inputForm(
                                  title: "Name",
                                  initValue: editProfileController.user!.name!,
                                  onSaved: (value) {
                                    editProfileController.user!.name = value;
                                  }),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Radio<String>(
                                              fillColor:
                                                  MaterialStateColor.resolveWith(
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
                                              fillColor:
                                                  MaterialStateColor.resolveWith(
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
                                              fillColor:
                                                  MaterialStateColor.resolveWith(
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
                                                  editProfileController
                                                      .user!.birthDay!)
                                              : '',
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            editProfileController
                                                .setBirthDay(context);
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
                                      editProfileController.user!.description ?? '',
                                  onSaved: (value) {
                                    editProfileController.user!.description = value;
                                  }),
                              _inputForm(
                                  title: 'Address',
                                  initValue:
                                      editProfileController.user!.address ?? '',
                                  onSaved: (value) {
                                    editProfileController.user!.address = value;
                                  }),
                              _inputForm(
                                  title: 'City',
                                  initValue: editProfileController.user!.city ?? '',
                                  onSaved: (value) {
                                    editProfileController.user!.city = value;
                                  }),
                              _inputForm(
                                  title: 'Country',
                                  initValue:
                                      editProfileController.user!.country ?? '',
                                  onSaved: (value) {
                                    editProfileController.user!.country = value;
                                  }),
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
                                    onPressed: () async {
                                      await editProfileController.onSaveInfo();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Successful change!"),
                                      ));
                                      Get.back();
                                    },
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
                          ),
                        );
                      }),
                ),
              ),
            );
          }
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
    required void Function(String) onSaved,
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
          TextFormField(
            onSaved: (value) {
              onSaved(value!);
            },
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
        ],
      ),
    );
  }
}
