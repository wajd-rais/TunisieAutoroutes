import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tunisie_autoroutes/constant/constant.dart';
import 'package:tunisie_autoroutes/screens/login-register/login.dart';

class checkEmail extends StatefulWidget {
  const checkEmail({super.key});

  @override
  State<checkEmail> createState() => _checkEmailState();
}

class _checkEmailState extends State<checkEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Text(
                "Réinitialisation du mot de",
                style: GoogleFonts.montserratAlternates(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
               Row(
                 children: [
                    Text(
                    "   passe",
                    style: GoogleFonts.montserratAlternates(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
              ),
                   Text(
                    " avec succès",
                    style: GoogleFonts.montserratAlternates(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: primaryColor),
              ),
                 ],
               ),
              SizedBox(
                height: 40,
              ),
             Image.asset("assets/images/Success.png"),
             SizedBox(
              width: 328,
              height: 51,
               child: ElevatedButton(
                        onPressed: () {
                           Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: Duration.zero,
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              loginScreen()));
                        },
                        child: Text(
                          "Continuer vers la connexion",
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
          
            ],
          ),
        ),
      ),
    );
  }

 
}