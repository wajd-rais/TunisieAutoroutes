import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tunisie_autoroutes/constant/constant.dart';
import 'package:tunisie_autoroutes/model/PostModel.dart';
import 'package:tunisie_autoroutes/screens/adminstateur/addPost.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text("Acceuil" , 
        style: GoogleFonts.montserrat(
          fontSize: 24 , 
          fontWeight: FontWeight.w600 , 
          color: Colors.black
        ),
        ),
        actions: [
          userData?["isAdmin"] == "true"
          ? IconButton(onPressed: (){
                 pushNewScreenWithRouteSettings(context,
                     screen: AddPostScreen(),
                     settings: RouteSettings(),
                     withNavBar: false,
                     pageTransitionAnimation:
                     PageTransitionAnimation.cupertino);
          }, 
           icon: Icon(Icons.add,  color: Colors.black,)) 
          : Text("")
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color.fromARGB(54, 158, 158, 158) , 
          borderRadius: BorderRadius.only(
            topRight:Radius.circular(65), 
            topLeft: Radius.circular(65),
          )
        ),
        child: Column(
          children: [
             SizedBox(height: 30,),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore
                .instance
                .collection("posts")
                .orderBy("date", descending: true)
                .snapshots() , 
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) { 
                  if(!snapshot.hasData){
                    return Center(
                      child:CircularProgressIndicator(),
                    ) ; 
                  }
                  if(snapshot.data!.docs.length == 0 ){
                     return Center(
                      child: Text("Pas des articles disponibles" , 
                      style: GoogleFonts.montserratAlternates(),
                      ),
                    ) ; 
                  }
                    List<Post> posts = snapshot.data!.docs.map((doc) {
                       return Post(
                        id : doc.id , 
                        description: doc["description"],
                        date: doc["date"].toString(),
                        pictureUrl: doc["imageUrl"],
                        title: doc["title"] , 
                                );
                              }).toList(); 
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder :(BuildContext context, int index) {
                      String dateTimeString = posts[index].date;
                      var A_title =  posts[index].title ; 
                      var A_description =  posts[index].description ; 
                      var A_picUrl =  posts[index].pictureUrl ;
                      var A_date =   posts[index].date ;
                      var id = posts[index].id ;
                    
            
                      return InkWell(
                        onTap: () {
                        
                          print(A_title); 
                          print(A_description); 
                          print(A_picUrl); 
                          print(A_date); 
                          print(id);
                          
                        },
                        onLongPress: () async {
                          userData?["isAdmin"] == "true"
                          ?
                          await FirebaseFirestore
                          .instance
                          .collection("posts")
                          .doc(id)
                          .delete()
                          : null;
                        },
                        child:SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                               
                                Text(A_title , 
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w800 , 
                                  fontSize: 14 , 
                                  color: Colors.black
                                ),
                                textAlign: TextAlign.center,
                                ) ,   
                                SizedBox(height: 5,),
                                Text(A_description , 
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500 , 
                                  fontSize: 12 , 
                                  color: Colors.black
                                ),
                                textAlign: TextAlign.center,
                                ) , 
                                SizedBox(height: 5,),
                                  Container(
                                  height: 150 , 
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(A_picUrl ,    
                                      ) , 
                                      fit: BoxFit.fitWidth
                                    )
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Divider(
                                  thickness: 1 , 
                                  color:Colors.black ,
                                )
                              ],
                            ),
                          ),
                        ) ,
                      ) ; 
                    },
                    ) ; 
                  
                },
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}