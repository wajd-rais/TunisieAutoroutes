import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;
  String title = "" ; 
  String description = "" ; 
  String imageUrl = "" ; 
  bool _isLoading = false ; 

  final Random _random = Random();

  String generateRandomName(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Créer une article", 
        style: GoogleFonts.montserrat(

        ),
        ),
        centerTitle: true,
      ), 
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text("Titre" , 
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700, 
                  fontSize: 22
                ),
                ) , 
                SizedBox(height: 20,) , 
                TextField(
                  style: GoogleFonts.montserrat(),
                  onChanged: (value) {
                    title = value ; 
                  },
                ) , 
                SizedBox(height: 30,) , 
                 Text("Description" , 
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700, 
                  fontSize: 22
                ),
                ) , 
                SizedBox(height: 20,) , 
                TextField(
                  style: GoogleFonts.montserrat(),
                  onChanged: (value) {
                    description = value ; 
                  },
                ) , 
                SizedBox(height: 40,) , 
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
                      SizedBox(height: 20,) , 
                     _pickedImage == null           
                      ? Text("Seelectionnez une image" , 
                         style: GoogleFonts.montserrat(
                         ) ) 
                        : Container(
                        height: MediaQuery.of(context).size.height*0.2,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_pickedImage!)
                          )
                        ),
                      )  , 
                      SizedBox(height: 50,) , 
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () async{
                            setState(() {
                              _isLoading = true ; 
                            });
                            final ref = FirebaseStorage.instance
                                .ref()
                                .child('posts_picture')
                                .child(generateRandomName(10) + '.jpg');
                                 await ref.putFile(_pickedImage!);
                                 imageUrl = await ref.getDownloadURL();
                                 await FirebaseFirestore
                                  .instance
                                  .collection("posts")
                                  .doc()
                                  .set({
                                    "title" : title , 
                                    "description" : description , 
                                    "imageUrl" : imageUrl , 
                                    "date" : DateTime.now()
                                  }) ; 
                                  setState(() {
                                    _isLoading=false ; 
                                  });
                                  Navigator.pop(context) ; 

                          },
                           child: Text("Publier", 
                           style: GoogleFonts.montserrat(
                            fontSize: 20 , 
                            fontWeight: FontWeight.w700
                           ),
                           ) , 
                           style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            )
                           ),
                           ),
                      ), 
                      SizedBox(height: 10,) , 
                      _isLoading == true 
                      ? Center(
                        child: CircularProgressIndicator(),
                      ) : Text("")
              ],
            ),
          ),
        ),
      ),
    );
  }
     handle_image_camera() async {
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