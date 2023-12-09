import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunisie_autoroutes/constant/constant.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  String? name = '';
  final ImagePicker _picker = ImagePicker();
  ImagePicker? imagePicker;
  File? _pickedImage;
  String? imageUrl;
  bool _isLoading = false;
  final Random _random = Random();

  String generateRandomName(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }

  var userData;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<DocumentSnapshot> getUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    String? uid = user!.uid;
    var result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      userData = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Edit profile",
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.green,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green,
                        width: 1,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _pickedImage == null
                            ? NetworkImage(userData?["imageUrl"] ?? "")
                            : FileImage(_pickedImage!) as ImageProvider<Object>,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              child: Text(
                "Edit photo",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: primaryColor),
              ),
              onTap: () {
                print(userData["imageUrl"]);
              },
            ),
            SizedBox(
              height: 5,
            ),
                 Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            handle_image_gallery();
                          },
                          child: Container(
                              height: 35,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(71, 158, 158, 158)),
                              child: Image.asset(
                                "assets/images/gallery.png",
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            handle_image_camera();
                          },
                          child: Container(
                              height: 35,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:  Color.fromARGB(71, 158, 158, 158)),
                              child: Image.asset(
                                "assets/images/camera.png",
                              )),
                        ),
                      ],
                    ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              child: Column(children: [
                SizedBox(
                  width: 330,
                  child: TextField(
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.montserrat(),
                      labelStyle: GoogleFonts.montserrat(),
                      counterStyle: GoogleFonts.montserrat(),
                      hintText: 'Edit your name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: '  Full name',
                      // counterText:
                      //     '*Please use a verified e-mail',
                    ),
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 40,
                    onChanged: (value) {
                      name = value;
                    },
                    // ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 70,
            ),
            SizedBox(
              width: 333,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final _user = FirebaseAuth.instance.currentUser;
                  final _uid = _user!.uid;
                  if (_pickedImage != null && name == '') {
                    setState(() {
                      _isLoading = true;
                    });
                    final ref = FirebaseStorage.instance
                        .ref()
                        .child('profile_picture')
                        .child(generateRandomName(10) + '.jpg');
                    await ref.putFile(_pickedImage!);
                    imageUrl = await ref.getDownloadURL();

                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(_uid)
                        .update({
                      // "full name": name.toString(),
                      "imageUrl": imageUrl.toString()
                    });
                    setState(() {
                      _isLoading = false;
                    });
                  } else if (_pickedImage == null && name != '') {
                    setState(() {
                      _isLoading = true;
                    });
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(_uid)
                        .update({
                      "full name": name.toString(),
                    });
                    setState(() {
                      _isLoading = false;
                    });
                  } else if (_pickedImage != null && name != '') {
                    final ref = FirebaseStorage.instance
                        .ref()
                        .child('profile_picture')
                        .child(generateRandomName(10) + '.jpg');
                    await ref.putFile(_pickedImage!);
                    imageUrl = await ref.getDownloadURL();

                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(_uid)
                        .update({
                      "full name": name.toString(),
                      "imageUrl": imageUrl.toString()
                    });
                    setState(() {
                      _isLoading = false;
                    });
                    
                  } else {
                    EasyLoading.showError('Pas de modification a été entrée');
                  }
                  setState(() {
                    
                  });
                  Navigator.pop(context) ; 
                },
                child: Text(
                  "Update profile",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(child: _isLoading ? CircularProgressIndicator() : null),
          ],
        ),
      ),
    );
  }

  handle_image_camera() async {
    // _requestPermissionCamera();
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    _pickedImage = File(pickedFile!.path);

    if (_pickedImage != null) {
      setState(() {
        _pickedImage;
      });
    } else {
      EasyLoading.showError('No image selected');
    }
  }

  handle_image_gallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    _pickedImage = File(pickedFile!.path);

    if (_pickedImage != null) {
      setState(() {
        _pickedImage;
      });
    } else {
      EasyLoading.showError('No image selected');
    }
  }
}