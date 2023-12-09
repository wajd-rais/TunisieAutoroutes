import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tunisie_autoroutes/constant/constant.dart';
import 'package:tunisie_autoroutes/screens/NavBar/Home.dart';
import 'package:tunisie_autoroutes/screens/NavBar/emergency.dart';
import 'package:tunisie_autoroutes/screens/NavBar/profile.dart';
import 'package:tunisie_autoroutes/screens/NavBar/station.dart';

class navBar extends StatefulWidget {
  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  // @override
  // void initState() {
  //   getUser_Data();

  //   super.initState();
  // }

  // var user_data;

  // Future<DocumentSnapshot> getUser_Data() async {
  //   final User? user1 = FirebaseAuth.instance.currentUser;
  //   String? _uid = user1!.uid;
  //   var result1 =
  //       await FirebaseFirestore.instance.collection('users').doc(_uid).get();
  //   setState(() {
  //     user_data = result1;
  //   });
  //   return result1;
  // }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    List<Widget> _buildScreens() {
      return [
        HomeScreen(), 
        EmergencyScreen(),
        StationScreen(), 
        ProfileScreen(), 
        ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          iconSize: 30,
          icon: LineIcon.home(
              ),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          iconSize: 32,
          icon: LineIcon.ambulance(
              ),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          iconSize: 32,
          icon:LineIcon.parking(
              ),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          iconSize: 32,
          icon: LineIcon.user(
              ),
          activeColorPrimary: primaryColor,
          inactiveColorPrimary: Colors.black,
        ),
      ];
    }

    return Scaffold(
        body:
            // user_data?["management"] == "enabled"
            //     ?
            PersistentTabView(
      context,
      navBarHeight: 65,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,

      //, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25)),

        //border: Border.all(color: Colors.black26)
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.elasticInOut,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    )
        // : FadeIn(
        //     delay: Duration(seconds: 2),
        //     child: Center(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Image.asset("assets/images/Rectangle.png"),
        //           SizedBox(
        //             height: 10,
        //           ),
        //           Text(
        //             "You are Disabled, contact the support",
        //             style: GoogleFonts.montserrat(
        //                 color: Colors.red,
        //                 fontWeight: FontWeight.w700,
        //                 fontSize: 16),
        //           )
        //         ],
        //       ),
        //     ),
        //   )
        );
  }
}