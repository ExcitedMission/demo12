import 'package:api_project/login.dart';
import 'package:api_project/upto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'splace.dart';
class homePage extends StatefulWidget {

  homePage({super.key});
  // String? username,email,mobile,country_code,password;

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
   var userID;
   var username = '';
   var email = '';
   var mobile = '';
   var country_code = '';

  Future<void> getData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      userID = prefs.getString('userId');
      username = prefs.getString('username')??'';   print(username);
      email = prefs.getString('email')??'';         print(email);
      mobile = prefs.getString('mobile')??'';       print(mobile);
      country_code = prefs.getString('country_code')??'';print(country_code);

    });

  }

@override
void initState() {
    // TODO: implement initState

    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        //elevation: 0,
        backgroundColor: Colors.greenAccent[200],
        foregroundColor: Colors.black87,
        title: Text('Welcome User'),
        actions: [
          IconButton(onPressed: ()async {
            // var sharedPref = await SharedPreferences.getInstance();
            // sharedPref.setBool(splaceState.KEYLOGIN, false);
            // Fluttertoast.showToast(
            //     msg: "Logged out",
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.CENTER,
            //     timeInSecForIosWeb: 1,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0
            // );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> upto()));
          }, icon: Icon(Icons.edit,color: Colors.deepOrange)),

          IconButton(onPressed: ()async {

            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> delete()));
          }, icon: Icon(Icons.delete,color: Colors.red[700])),

          IconButton(onPressed: ()async {
            var sharedPref = await SharedPreferences.getInstance();
            sharedPref.setBool(splaceState.KEYLOGIN, false);
            Fluttertoast.showToast(
                     msg: "Logged out",
                     toastLength: Toast.LENGTH_SHORT,
                     gravity: ToastGravity.CENTER,
                     timeInSecForIosWeb: 1,
                     backgroundColor: Colors.red,
                     textColor: Colors.white,
                     fontSize: 16.0
                 );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> login()));
            }, icon: Icon(Icons.logout,color: Colors.green[700])),

        ],
      ),

      body: Column(
        children: [
          SizedBox(height: 10,),

          Container(

            width: 300,
            padding: EdgeInsets.only(bottom: 10),
            margin: EdgeInsets.only(left: 30,right: 30,top: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.deepOrange[300],),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("\n  User Data Show ",style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,),),
                SizedBox(height: 20,),
                Text("  Id:              ${userID}",style: TextStyle(fontSize: 18,),),
                Text("  Name:       ${username}",style: TextStyle(fontSize: 18,),),
                Text("  Email:        ${email}",style: TextStyle(fontSize: 18),),
                Text("  Mobile:      ${mobile}",style: TextStyle(fontSize: 18),),
                Text("  C_Code:    +${country_code}",style: TextStyle(fontSize: 18),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
