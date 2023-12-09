import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tunisie_autoroutes/constant/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class contactUs extends StatefulWidget {
  const contactUs({super.key});

  @override
  State<contactUs> createState() => _contactUsState();
}

class _contactUsState extends State<contactUs> {
  var phoneNumber = "tel:+216 70 555 780";
  var facebook = "https://www.facebook.com/profile.php?id=100067077537076";
  var mail = "mailto:tunisie.autoroutes@planet.tn";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Contact us",
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Color.fromRGBO(0, 0, 0, 1)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Vous pouvez nous contacter via l’un de ces canaux",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              InkWell(
                onTap: () async {
                  await launch(mail);
                },
                child: Container(
                  height: 55,
                  width: 328,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                      child: Text(
                    "tunisie.autoroutes@planet.tn",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  await launch(phoneNumber);
                },
                child: Container(
                  height: 55,
                  width: 328,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                      child: Text(
                    "+216 70 555 780",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  await launch(facebook);
                },
                child: Container(
                 height: 55,
                  width: 328,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/fb.png" ,
                          height: 30 , 
                          width: 30,
                          ),
                          SizedBox(width: 5,),
                          Text(
                    "Tunisie Autoroutes (page officielle)",
                    style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                             fontSize: 16),
                  ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                width: 333,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Continue",
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
            ],
          ),
        ),
      ),
    );
  }
}