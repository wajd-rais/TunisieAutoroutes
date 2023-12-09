import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';
import 'package:tunisie_autoroutes/constant/constant.dart';
import 'package:tunisie_autoroutes/model/urgenceModel.dart';
import 'package:tunisie_autoroutes/providers/locationProvider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:telephony/telephony.dart';


class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
   bool isLongPressing = false;
   var User_Latitude ; 
   var User_longitude ; 
     void initState() {
    getUserData();
    super.initState();
  }

  var userData;

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
   final locationData = Provider.of<LocationProvider>(context);
   setState(() {
     User_Latitude = locationData.latitude ; 
     User_longitude = locationData.longitude ; 
    });
    final Telephony telephony = Telephony.instance;


    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        shadowColor:  Colors.transparent,
        foregroundColor: Colors.black, 
        title: Text("Urgence" , 
        style: GoogleFonts.montserrat(
          fontSize: 24 , 
          fontWeight: FontWeight.w600
        ),
        ),
      ),
      body: 
      userData?["isAdmin"] == "false"
      ? Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromARGB(54, 158, 158, 158) , 
          borderRadius: BorderRadius.only(
            topRight:Radius.circular(65), 
            topLeft: Radius.circular(65),
          )
        ),
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("En cas de situation critique, appuyez sur le bouton pour obtenir de l'aide immédiate. Soyez assuré(e) que nous sommes là pour vous aider sur les autoroutes." ,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 15 , 
                  fontWeight: FontWeight.w400
                ),
                ),
                SizedBox(height: 30,) , 
                GestureDetector(
                  onLongPress: () async{
                    final User? user = FirebaseAuth.instance.currentUser ; 
                    final _uid = user!.uid ; 
                      var contact1 = userData["contact1"];
                      var contact2 = userData["contact2"];
                      var contact3 = userData["contact3"];
                      String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$User_Latitude,$User_longitude';
                      String message = "C'est une urgence!\n $googleMapsUrl";
                      var numWajd ="tel:25145661" ;

                      // List<String> recipents = [contact1, contact2 , contact3];
                      // telephony.sendSms(
	                    //    to: contact1,
	                    //    message: message
	                    //            );
                    //    String _result = await sendSMS(message: message, recipients: recipents, sendDirect: true)
                    //   .catchError((onError) {
                    //  print(onError);
                    //     });
                    // print(_result);
                    //   // badelt wakt mn timestamp li string
                   setState(() {
                   isLongPressing = true;
                     });
                    //  sendSms
                    // sendSmsByDefaultApp
                      telephony.sendSms(
	                       to: contact1,
	                       message: message
	                               );
                                 await launch(numWajd);
                     await FirebaseFirestore
                     .instance
                     .collection("urgences")
                     .doc(_uid)
                     .set({
                      "user name" : userData?["full name"] , 
                      "time" : DateTime.now() , 
                      "latitude" : User_Latitude , 
                      "longitude" : User_longitude , 
                      "vehicule1" : userData?["vehicule1"], 
                      "vehicule2" :userData?["vehicule2"] , 
                      "vehicule3" :userData?["vehicule3"] ,
                     });
                     await FirebaseFirestore
                     .instance
                     .collection("users")
                     .doc(_uid)
                     .collection("urgences")
                     .doc()
                     .set({
                      "time" : DateTime.now() , 
                      "latitude" : User_Latitude , 
                      "longitude" : User_longitude , 
                     });
                     EasyLoading.showSuccess("Votre déclaration a été envoyé");
                  },
                   onLongPressEnd: (_) {
                     setState(() {
                     isLongPressing = false;
                       });
                     },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Color(0XFFFF0000),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: isLongPressing
                              ? [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.5),
                            blurRadius: 1.0,
                            spreadRadius: 25.0,
                          ),
                        ]
                      : [],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ) 
      : Center(
        child: Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore
                .instance
                .collection("urgences")
                // .orderBy("date")
                .snapshots() , 
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) { 
                  if(!snapshot.hasData){
                    return Center(
                      child:CircularProgressIndicator(),
                    ) ; 
                  }
                  if(snapshot.data!.docs.length == 0 ){
                     return Center(
                      child: Text("Pas des cas d'urgences déclarées" , 
                      style: GoogleFonts.montserratAlternates(),
                      ),
                    ) ; 
                  }
                    List<UrgenceModel> urgences = snapshot.data!.docs.map((doc) {
                       return UrgenceModel(
                        latitude: doc["latitude"].toString(), 
                        longitude: doc["longitude"].toString(), 
                        date: doc["time"].toString(),
                        userName: doc["user name"],
                        car1: doc["vehicule1"], 
                        car2: doc["vehicule2"],
                        car3: doc["vehicule3"]
                     
                                );
                              }).toList(); 
                  return ListView.builder(
                    itemCount: urgences.length,
                    itemBuilder :(BuildContext context, int index) {
                      String dateTimeString = urgences[index].date;
                      var lat =  urgences[index].latitude ; 
                      var lon =  urgences[index].longitude ; 
                      var date = urgences[index].date ;
                      var name = urgences[index].userName ;
                      var car1 = urgences[index].car1 ;
                      var car2 =urgences[index].car2 ;
                      var car3 =urgences[index].car3 ;

                        int seconds = int.parse(date.split(',')[0].split('=')[1]);
                        int nanoseconds = int.parse(date.split(',')[1].split('=')[1].replaceAll(')', ''));
                            double timestampCombined = seconds + (nanoseconds / 1e9);
                            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch((timestampCombined * 1000).toInt());
                            String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
                      return SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              ListTile(
                                leading:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(name , 
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500 , 
                                        fontSize: 14 , 
                                        color: primaryColor
                                      ),
                                      textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 5,),
                                       Text(formattedDate , 
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500 , 
                                    fontSize: 12 , 
                                    color: Colors.black
                                  ),
                                  textAlign: TextAlign.center,
                                  ) ,
                                  ],
                                ) ,
                                  title:   Text(car1 , 
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400 , 
                                    fontSize: 12 , 
                                    color: Colors.black
                                  ),
                                  textAlign: TextAlign.left,
                                  ) ,
                                  trailing: IconButton(onPressed: (){
                                    String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
                                    print(googleMapsUrl);
                                    launch(googleMapsUrl);
                                  },
                                   icon: Image.asset("assets/images/place.png")
                                   ),
                              ),
                               Divider(
                                    thickness: 1 , 
                                    color:Colors.black ,
                                  )
                            ],
                          ),
                        ),
                      ) ; 
                    },
                    ) ; 
                  
                },
                
              ),
            ),
      )
    );
  }
}