import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tunisie_autoroutes/constant/constant.dart';
import 'package:tunisie_autoroutes/screens/login-register/check_email.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    String? email ;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Réinitialiser le mot de passe",
                    style: GoogleFonts.montserratAlternates(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                 
                  Text(
                    "Récupérez votre compte en réinitialisant votre mot de passe",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                 
                  SizedBox(
                    width: 330,
                    child: TextField(
                      style: GoogleFonts.montserrat(),
                      decoration: InputDecoration(
                        hintText: 'address@mail.com',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: '  E-mail address',
                      ),
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 40,
                      onChanged: (value) {
                        email = value;
                      },
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 350,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        resetPassword(email.toString());
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        
                       
                      },
                      child: Text(
                        "Poursuivez",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,) , 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Pas encore de compte ? " , 
                      style: GoogleFonts.montserrat(
                        color: Colors.black , 
                        fontWeight: FontWeight.w400 , 
                        fontSize: 16
                      ),
                      ), 
                       Text("Créer un compte" , 
                      style: GoogleFonts.montserrat(
                        color: primaryColor , 
                        fontWeight: FontWeight.w400 , 
                        fontSize: 15
                      ),
                      ), 
                    ],
                  ) , 
                  SizedBox(height: MediaQuery.of(context).size.height*0.32,),
                   Text("Tunisie Autoroutes", 
              style: GoogleFonts.montserratAlternates(
              fontSize: 24 , 
              fontWeight: FontWeight.w800 , 
              color: primaryColor
              ),
              )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 void resetPassword(String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: primaryColor,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Un lien a été envoyé sur votre email' , 
                    style: GoogleFonts.montserratAlternates(),
                    ),
                  ],
                ),
               
              ),
            );
              Navigator.of(context).push(PageRouteBuilder(
                         transitionDuration: Duration.zero,
                         pageBuilder: (context, animation, secondaryAnimation) =>
                         checkEmail()));
                  } on FirebaseAuthException catch (e) {
                       print('$e');
                       if (e.code == "missing-email") {
                           ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                backgroundColor: primaryColor,
                                 content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text('SVP entrez votre email', 
                                     style: GoogleFonts.montserratAlternates(),
                                     ),
                                   ],
                                 ),
                               ),
                             );
                       } else if (e.code == "invalid-email") {
                           ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                backgroundColor: primaryColor,
                                 content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text('email invalide', 
                                     style: GoogleFonts.montserratAlternates(),
                                     ),
                                   ],
                                 ),
                               ),
                             );
                       } else if (e.code == "user-not-found") {
                          ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                backgroundColor: primaryColor,
                                 content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text("pas d'utilisateur avec cet email", 
                                     style: GoogleFonts.montserratAlternates(),
                                     ),
                                   ],
                                 ),
                               ),
                             );
                       } else if (e.code == "network-request-failed") {
                          ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                backgroundColor: primaryColor,
                                 content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text('Probleme de connexion' , 
                                     style: GoogleFonts.montserratAlternates(),
                                     ),
                                   ],
                                 ), 
                               ),
                             );
                       } else {
                           ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                backgroundColor: primaryColor,
                                 content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text('erreur inconnu, contactez-nous' , 
                                     style: GoogleFonts.montserratAlternates(),
                                     ),
                                   ],
                                 ),
                               ),
                             );
      }
    }
  }
}