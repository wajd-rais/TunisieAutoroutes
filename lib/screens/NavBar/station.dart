import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tunisie_autoroutes/constant/constant.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class StationScreen extends StatefulWidget {
  const StationScreen({super.key});

  @override
  State<StationScreen> createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
   List<String> governorates = [
    "Select",
    "ben arous",
    "sousse",
    "jandouba",
    "ariana",
    "bizerte",
    "nabeul",
    "mahdia",
    "sfax",
    "gabes",
    "mednine",
    "manouba",
    "beja",
    "kairouan",
    "el fajja",
  ];
    Map<String, List<String>> cities = {
    "Select":["Select"],
    "ben arous": ["mornag", "borj cedria"],
    "sousse": ["hergla", "sousse", "msaken", "bouficha", "enfidha", "enfidha aeroport", "sidi bouali", "kalaa kbira", "kalaa sghira", "sousse sud", "msaken knaies", "bourjine", "sidi khlifa"],
    "jandouba": ["boussalem"],
    "ariana": ["sidi thabet"],
    "bizerte": ["menzil jmil", "utique", "el alia"],
    "nabeul": ["grombalia", "turki", "hamamet nord", "golfe", "hama sud", "hama centre"],
    "mahdia": ["karkar", "el jem", "neffatia"],
    "sfax": ["el hancha", "sfax nord (sidi salah)", "sfax sud", "el mahres", "el ghraiba", "skhira", "agareb", "bousaid", "skhira"],
    "gabes": ["el metouia", "gabes nord", "gabes sud"],
    "mednine": ["mednine", "djerba", "ben guerdane"],
    "manouba": ["borj el amri", "el fajjah"],
    "beja": ["mjez el beb", "testour", "oued zarga", "beja"],
    "kairouan": ["el griaat"],
  };
  String selectedGovernorate = "Select";
  String selectedCity = "Select";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50)
              ),
              child: Image.asset("assets/images/Capture.png")),
                SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: color2 , 
                    borderRadius: BorderRadius.circular(15), 
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      // isExpanded: true,
                    value: selectedGovernorate,
                     items: governorates
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style:  GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
                buttonStyleData: ButtonStyleData(
              height: 50,
              width: 130,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: primaryColor,
                  width: 2
                ),
                color: color2,
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: primaryColor,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: color2,
              ),
              offset:  Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius:  Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData:  MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGovernorate = newValue!;
                        selectedCity = cities[newValue]?.first ?? "";
                      });
                    },
                  ),
                ),
                ),
                SizedBox(width: 25),
                 Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: color2 , 
                    borderRadius: BorderRadius.circular(15), 
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      // isExpanded: true,
                    value: selectedCity,
                    
                     items: cities[selectedGovernorate]?.map((String city)
                => DropdownMenuItem<String>(
                      value: city,
                      child: Text(
                        city,
                        style:  GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
                buttonStyleData: ButtonStyleData(
              height: 50,
              width: 200,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: primaryColor,
                  width: 2
                ),
                color: color2,
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: primaryColor,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: color2,
              ),
              offset:  Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius:  Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData:  MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCity = newValue!;
                        // selectedCity = cities[newValue]?.first ?? "";
                      });
                    },
                  ),
                ),
                ),
                
              ],
            ),
            SizedBox(height: 20,),
            if(selectedCity =="mornag")
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wc) , 
                Icon(Icons.mosque) , 
                Icon(Icons.food_bank)
              ],
            ),
             if(selectedCity =="hergla")
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wc) , 
                Icon(Icons.mosque) , 
                Icon(Icons.food_bank)
              ],
            ),
               if(selectedCity =="borj cedria")
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wc) ,
                SizedBox(width: 10,), 
                Image.asset("assets/images/camera.png", 
                height: 30,
                ), 
                SizedBox(width: 10,), 
                Icon(Icons.food_bank)
              ],
            ),
          
          ],
        ),
      ),
    );
  }
}