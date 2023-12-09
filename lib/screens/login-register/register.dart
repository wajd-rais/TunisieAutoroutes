import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:animate_do/animate_do.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunisie_autoroutes/NavBar/NavBar.dart';
import 'package:tunisie_autoroutes/constant/constant.dart';
import 'package:tunisie_autoroutes/screens/NavBar/Home.dart';
import 'package:tunisie_autoroutes/screens/login-register/login.dart';
import 'package:tunisie_autoroutes/screens/login-register/terms.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
   GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _handleSignIn() async {
   GoogleSignInAccount? googleUser = await GoogleSignIn().signIn() ; 
   GoogleSignInAuthentication? googleAuth= await googleUser!.authentication ;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, 
      idToken: googleAuth.idToken, 
    );
    UserCredential _userCredential = await FirebaseAuth.instance.signInWithCredential(credential) ; 
    print(_userCredential.user!.displayName); 
  }

  bool _acceptedTerms = false;
  String? email;
  String? f_name;
  String? password;
  String? p_confirm;
  String? number;
  var _fNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmController = TextEditingController();
  var _numberController =TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;
  String? imageUrl;

  final Random _random = Random();
      String car1 = "";
    String car2 = "";
    String car3 = "";
    String num1 = "";
    String num2 = "";
    String num3 = "";

  String generateRandomName(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }

  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
    
            body: SingleChildScrollView(
                child: FadeInLeft(
                  delay: Duration(milliseconds: 200),
                  child: Padding(
                    padding:  EdgeInsets.all(15.0),
                    child: Center(
                        child: Column(
                        
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                          SizedBox(
                        height: 10,
                          ),
                          Row(
                           children: [
                          
                          Text(
                            "S'inscrire",
                            style: GoogleFonts.montserratAlternates(
                                fontSize: 34, fontWeight: FontWeight.bold),
                           ),
                           ],
                          ),
                          SizedBox(
                          height: 10,
                          ),
                     
                          Text(
                           "Bienvenue à bord, nous espérons que vous apprécierez votre temps avec nous",
                           textAlign: TextAlign.left,
                           style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                             ),
                          SizedBox(
                          height: 20,
                          ),
                          CircleAvatar(
                            radius: 70,
                            child: _pickedImage == null
                             ? Text("Séelectionner une photo" , 
                             style: GoogleFonts.montserrat(),
                             textAlign: TextAlign.center,
                             )
                             : null , 
                             backgroundImage:
                             _pickedImage == null 
                             ? null
                             : FileImage(_pickedImage!)
                          
                          ),
                          SizedBox(height: 10,) , 
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
                          SizedBox(height: 20,),
                          SizedBox(
                           width: 330,
                           child: TextFormField(
                          style: GoogleFonts.montserrat() ,
                          textCapitalization: TextCapitalization.sentences,
                          controller: _fNameController,
                          decoration: InputDecoration(
                            hintText: "Nom d'utilisateur",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "  Nom d'utilisateur",
                          ),
                          autofocus: false,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'SVP entrez vote nom';
                            } else {
                              setState(() {
                                f_name = value;
                              });
                              return null;
                            }
                           },
                           onChanged: (value) {
                             f_name = value;
                            },
                          ),
                          ),
                          SizedBox(
                          height: 20,
                           ),
                            SizedBox(
                           width: 330,
                           child: TextFormField(
                          style: GoogleFonts.montserrat() ,
                          textCapitalization: TextCapitalization.sentences,
                          controller: _numberController,
                          decoration: InputDecoration(
                            hintText: "Numero du telephone",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "  Numero du telephone",
                          ),
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'SVP entrez vote nom';
                            } else {
                              setState(() {
                                number = value;
                              });
                              return null;
                            }
                           },
                           onChanged: (value) {
                             number = value;
                            },
                          ),
                          ),
                          SizedBox(
                          height: 20,
                           ),
                          SizedBox(
                           width: 330,
                           child: TextFormField(
                          style: GoogleFonts.montserrat(),
                          controller: _emailController,
                          decoration: InputDecoration(
                           
                            hintText: 'address@mail.com',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: '  E-mail',
                          ),
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'SVP entrez votre e-mail';
                            } else {
                              setState(() {
                                email = value;
                              });
                              return null;
                            }
                          },
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 330,
                        child: TextFormField(
                          style: GoogleFonts.montserrat(),
                          controller: _passwordController,
                          decoration: InputDecoration(
                          
                            hintText: 'Mot de passe',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: '  Mot de passe',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          autofocus: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'SVP entrez votre mot de passe';
                            } else {
                              setState(() {
                                password = value;
                              });
                              return null;
                            }
                          },
                          onChanged: (value) {
                            password = value;
                          },
                          obscureText: _obscureText,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 330,
                        child: TextFormField(
                          style: GoogleFonts.montserrat(),
                          controller: _confirmController,
                          decoration: InputDecoration(
                       
                            hintText: 'Confirmer le mot de passe',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: '  Confirmer le mot de passe',
                          ),
                          autofocus: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Mot de passe n'est pas confirmé";
                            } else if (value != _passwordController.text) {
                              return "n'est pas identique";
                            } else {
                              setState(() {
                                p_confirm = value;
                              });
                              return null;
                            }
                          },
                          onChanged: (value) {
                            p_confirm = value;
                          },
                          obscureText: true,
                        ),
                      ),
                      CheckboxListTile(
                        title: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "J'accepte ",
                                  style: GoogleFonts.montserratAlternates(
                                    fontSize: 14,
                                  ),
                                ),
                                InkWell(
                                  child: Text(
                                    "the terms and conditions",
                                    style: GoogleFonts.montserratAlternates(
                                        fontSize: 12, color: primaryColor),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                        transitionDuration: Duration.zero,
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            TermsScreen()));
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'de Tunisie Autoroutes',
                                  style: GoogleFonts.montserratAlternates(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        value: _acceptedTerms,
                        onChanged: (newValue) {
                          setState(() {
                            _acceptedTerms = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 350,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _acceptedTerms
                              ? () async {
                                  // var _token = await _firebaseMessaging.getToken();
                                                            if (_pickedImage == null) {
                              EasyLoading.showError('No picture picked');
                                 } else if (_formKey.currentState!.validate()) {
                                    try {                    
                                        setState(() {
                                          _isLoading = true;
                                        });
                                  final ref = FirebaseStorage.instance
                                  .ref()
                                  .child('Profile_Picture')
                                  .child(generateRandomName(10) + '.jpg');
                                   await ref.putFile(_pickedImage!);
                                   imageUrl = await ref.getDownloadURL();
                                       
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: email!.trim(),
                                                password: password!.trim());
    
                                          final User? userr =
                                            FirebaseAuth.instance.currentUser;
                                          final _uid = userr!.uid;
                                          await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(_uid)
                                            .set({
                                          "full name": "$f_name",
                                          "email": "$email",
                                          "id": _uid,
                                          "isAdmin": "false",
                                          "password" : password ,
                                          "imageUrl": imageUrl,
                                          "telephone": number,
                                          "vehicule1" : "" , 
                                          "vehicule2" : "" , 
                                          "vehicule3" : "" , 
                                          "contact1": "" , 
                                          "contact2": "" , 
                                          "contact3": "" , 
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => navBar(),
                                            ));
                  
                                        EasyLoading.showSuccess(
                                            'Utilisateur avec le nom $f_name a été crée');
                                              showDialog(
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        child: AlertDialog( 
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0), 
                              side: BorderSide(
                                color: primaryColor, 
                                width: 3
                              )
                              ),
                          title: Text("Pour compléter l'inscription, enregistrez jusqu'à trois véhicules et trois contacts d'urgence pour une meilleure assistance en cas de situation critique.",
                          style: GoogleFonts.montserrat(
                            color: primaryColor,
                            fontSize: 10, 
                            fontWeight: FontWeight.w600
                          ),
                          textAlign: TextAlign.center,
                          ),
                          content: Text("Premiére etape :  Enregistrer jusqu’a trois véhicules", 
                          style: GoogleFonts.montserrat(
                            fontSize: 12 , 
                            fontWeight: FontWeight.w700 , 
                            color: primaryColor
                          ),
                          textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                             SizedBox(
                                          width: 330,
                                          height: 50,
                                          child: TextField(
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.montserrat(),
                          labelStyle: GoogleFonts.montserrat(),
                          counterStyle: GoogleFonts.montserrat(),
                          hintText: 'Vehicule 1',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, 
                              width: 5
                            ),
                              borderRadius: BorderRadius.circular(15)),
                          labelText: 'Vehicule 1',
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        
                        onChanged: (value) {
                          car1 = value;
                        },
                        // ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                         SizedBox(
                                          width: 330,
                                          height: 50,
                                          child: TextField(
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.montserrat(),
                          labelStyle: GoogleFonts.montserrat(),
                          counterStyle: GoogleFonts.montserrat(),
                          hintText: 'Vehicule 2',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, 
                              width: 5
                            ),
                              borderRadius: BorderRadius.circular(15)),
                          labelText: 'Vehicule 2',
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        
                        onChanged: (value) {
                          car2 = value;
                        },
                        // ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                         SizedBox(
                                          width: 330,
                                          height: 50,
                                          child: TextField(
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.montserrat(),
                          labelStyle: GoogleFonts.montserrat(),
                          counterStyle: GoogleFonts.montserrat(),
                          hintText: 'Vehicule 3',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, 
                              width: 5
                            ),
                              borderRadius: BorderRadius.circular(15)),
                          labelText: 'Vehicule 3',
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        
                        onChanged: (value) {
                          car3 = value;
                        },
                        // ),
                                          ),
                                        ),
                                        SizedBox(height: 15,), 
                                        Text("deuxiéme etape :  Enregistrer jusqu’a trois contacts.", 
                                         style: GoogleFonts.montserrat(
                            fontSize: 12 , 
                            fontWeight: FontWeight.w700 , 
                            color: primaryColor
                          ),
                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 15,),
                               SizedBox(
                                          width: 330,
                                          height: 50,
                                          child: TextField(
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.montserrat(),
                          labelStyle: GoogleFonts.montserrat(),
                          counterStyle: GoogleFonts.montserrat(),
                          hintText: 'contact 1',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, 
                              width: 5
                            ),
                              borderRadius: BorderRadius.circular(15)),
                          labelText: 'contact 1',
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        
                        onChanged: (value) {
                          num1 = value;
                        },
                        // ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                         SizedBox(
                                          width: 330,
                                          height: 50,
                                          child: TextField(
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.montserrat(),
                          labelStyle: GoogleFonts.montserrat(),
                          counterStyle: GoogleFonts.montserrat(),
                          hintText: 'contact 2',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, 
                              width: 5
                            ),
                              borderRadius: BorderRadius.circular(15)),
                          labelText: 'contact 2',
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        
                        onChanged: (value) {
                          num2 = value;
                        },
                        // ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                         SizedBox(
                                          width: 330,
                                          height: 50,
                                          child: TextField(
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.montserrat(),
                          labelStyle: GoogleFonts.montserrat(),
                          counterStyle: GoogleFonts.montserrat(),
                          hintText: 'contact 3',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, 
                              width: 5
                            ),
                              borderRadius: BorderRadius.circular(15)),
                          labelText: 'contact 3',
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        
                        onChanged: (value) {
                          num3 = value;
                        },
                        // ),
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: ElevatedButton(onPressed: ()async{
                                    final User? user = FirebaseAuth.instance.currentUser;
                                    final _uid = user!.uid;
                                    await FirebaseFirestore.instance.collection("users")
                                    .doc(_uid).update({
                                      "vehicule1":car1 , 
                                      "vehicule2":car2 , 
                                      "vehicule3":car3 ,
                                      "contact1": num1 , 
                                      "contact2": num2 , 
                                      "contact3": num3 , 
                      
                                    });
                                          Navigator.of(context).push(PageRouteBuilder(
                                           transitionDuration: Duration.zero,
                                           pageBuilder: (context, animation, secondaryAnimation) =>
                                           navBar()));
                      
                                  },
                                   child: Text("Confirmer", 
                                   style: GoogleFonts.montserrat(
                                    fontSize: 14 , 
                                    fontWeight: FontWeight.w600
                                   ),
                                   ), 
                                   style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(35.0)),
                                   ),
                                   ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'weak-password') {
                                        snackbar(context,"Invalid password") ; 
                                      } else if (e.code == 'invalid-email') {
                                        snackbar(context,"Invalid email address") ;
                                      } else if (e.code == 'email-already-in-use') {
                                        snackbar(context,"This email address is already in use") ;
                                      }
                                    } catch (ex) {
                                      print(ex);
                                    }
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                }
                              : null,
                          child: Text(
                            "S'inscrire",
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w600),
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
                      SizedBox(
                          child: _isLoading ? CircularProgressIndicator() : null),
                      SizedBox(
                        height: 10,
                      ),
                      Text("____________________ OU ____________________" , 
                      style: GoogleFonts.montserrat(),
                      ),
                      SizedBox(height: 10,) , 
                      Text("S'inscrire en utilisant", 
                      style: GoogleFonts.montserrat(),
                      ),
                      SizedBox(height: 15,) , 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Container(
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                 color: Color.fromARGB(20, 158, 158, 158) ,
                                  borderRadius: BorderRadius.circular(15) , 
                                  
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/fb.png" , 
                                    height: 30,
                                    ),
                                    SizedBox(width: 10,),
                                    Text("Facebook" , 
                                    style: GoogleFonts.montserrat(),
                                    
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                
                              },
                            ) , 
                            SizedBox(width: 20,),
                             InkWell(
                               child: Container(
                                width: 120,
                                height: 40,
                                decoration: BoxDecoration(
                                color: Color.fromARGB(20, 158, 158, 158) ,
                                  borderRadius: BorderRadius.circular(15) , 
                                  
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/google.png" , height: 25,),
                                    SizedBox(width: 10,),
                                    Text("Google" , 
                                    style: GoogleFonts.montserrat(),
                                    
                                    )
                                  ],
                                ),
                                                       ),
                                                       onTap: () {
                                                         _handleSignIn() ;
                                                       },
                             )
    
    
                      ],),
                        SizedBox(
                        height: 20,
                      ),
                      FadeIn(
                        delay: Duration(seconds: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Vous avez déjà un compte ? ",
                              style: GoogleFonts.montserratAlternates(
                                fontSize: 13,
                              ),
                            ),
                            InkWell(
                              child: Text(
                                "Connectez-vous ici",
                                style: GoogleFonts.montserratAlternates(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    transitionDuration: Duration.zero,
                                    pageBuilder: (context, animation, secondary) =>
                                        loginScreen()));
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ])),
                  ),
                ))),
      ),
    );
  }
      void snackbar(BuildContext context, String? titlee,) {
        AnimatedSnackBar.material(
        titlee!,
        type: AnimatedSnackBarType.error,
        duration: Duration(seconds: 4),
        mobileSnackBarPosition:
           MobileSnackBarPosition.bottom,
     ).show(context);
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