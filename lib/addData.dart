import 'dart:convert';

import 'package:api_project/login.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';

class addData extends StatefulWidget {
  const addData({super.key});

  @override
  State<addData> createState() => _addDataState();
}

class _addDataState extends State<addData> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController country_code = TextEditingController();
  TextEditingController password = TextEditingController();

  void signup() async{
    try{
      Response response=await post(
          Uri.parse('https://alphawizzserver.com/jozzby_bazar_new/app/v1/api/register_user'),
          body: {
            'name' : username.text.toString(),
            'email' : email.text.toString(),
            'mobile' : mobile.text.toString(),
            'country_code' : "+91",//country_code.text.toString(),
            'password' : password.text.toString(),
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        if(data['error']==false){
          print('account created successfully');
          Fluttertoast.showToast(
              msg: "${data["message"]}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));

      }else {
          print('Failed');
          Fluttertoast.showToast(
              msg: "${data["message"]}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }else{

      }
    }catch(e){
      print(e.toString());
    }
  }



  GlobalKey<FormState> formkey=GlobalKey<FormState>();
  void validate(){
    if(formkey.currentState!.validate()){
      print("ok");
    }else{
      print("Error");
    }
  }
  bool _obscureText = true;
  late String _password;
// Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30,right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(Icons.account_circle,size: 100,color: Colors.black,),
                      SizedBox(height: 20,),
                      Text('Enter User Detaits-',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                      SizedBox(height: 10,),
                      //name
                      TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.accessibility_sharp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.greenAccent)
                          ),
                        ),
                          validator: (val){
                            if(val!.isEmpty){
                              return "Name is required";
                            }else{
                              return null;
                            }
                          },
                      ),
                      SizedBox(height: 15,),
                      //email
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_rounded),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.greenAccent)
                          ),
                        ),
                        validator: (val){
                          if(val!.isEmpty)
                          {
                            return 'Please a Enter';
                          }
                          if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val)){
                            return 'Please a valid Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15,),
                      //phone
                      TextFormField(
                        controller: mobile,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Mobile',
                          labelText: 'Mobile',
                          prefixIcon: Icon(Icons.call),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.greenAccent)
                          ),
                        ),
                        validator: (val){
                          if(val!.isEmpty){
                            return "Required ";
                           }
                          else{
                            return null;
                          }
                        },
                      ),

                      //country code
                      TextFormField(
                        controller: country_code,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Country code',
                          labelText: "Country code",
                          prefixIcon: Icon(Icons.control_point_duplicate_sharp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.greenAccent)
                          ),
                        ),
                        validator: (val){
                          if(val!.isEmpty)
                          {
                            return 'Please Enter Country Code';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15,),
                      //password
                      TextFormField(
                        controller: password,

                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.password,color: Colors.black54,),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.greenAccent)
                          ),
                          suffixIconColor: MaterialStateColor.resolveWith((states) =>
                          states.contains(MaterialState.focused)
                              ? Colors.black
                              : Colors.black54),
                          labelText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText; // Toggle password visibility
                              });
                            },
                          ),
                          //floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(color: Colors.black87),
                          //prefixIcon: Icon(Icons.lock),
                          prefixIconColor: Colors.black,
                          fillColor: Colors.black,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        validator: (val) => val!.length < 6 ? 'Password too short.' : null,
                        onSaved: (val) => _password = val!,
                        obscureText: _obscureText,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 60,),

                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          GestureDetector(
                            onTap: (){
                              validate();
                              signup();
                            },
                            child: Container(height: 37,width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.pinkAccent[100],
                                    borderRadius: BorderRadius.circular(5)),

                                child: Center(child: Text('ADD DATA',style: TextStyle(fontWeight: FontWeight.bold,),))),
                          ),
                          SizedBox(width: 40,),

                          ElevatedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (contact)=>login()));
                            },
                            style: ElevatedButton.styleFrom(

                              backgroundColor: Colors.greenAccent[400],
                            ),
                            child: Text('    LOGIN    ',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}








// import 'package:api_project/AppButton.dart';
// import 'package:api_project/login.dart';
// import 'package:api_project/home.dart';
// import 'package:flutter/material.dart';
// // import 'package:http_methods/app_button.dart';
// // import 'package:http_methods/base_client.dart';
// // import 'package:http_methods/user.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       backgroundColor: const Color(0xFF1E1E1E),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const FlutterLogo(size: 72),
//               AppButton(
//                 operation: 'GET',
//                 operationColor: Colors.lightGreen,
//                 description: 'Fetch users',
//                 onPressed: () async {
//                   var response = await BaseClient().get('/users').catchError((err) {});
//                   if (response == null) return;
//                   debugPrint('successful:');
//
//                   var users = userFromJson(response);
//                   debugPrint('Users count: ' + users.length.toString());
//                 },
//               ),
//               AppButton(
//                 operation: 'POST',
//                 operationColor: Colors.lightBlue,
//                 description: 'Add user',
//                 onPressed: () async {
//                   var user = User(
//                     name: 'Afzal Ali',
//                     qualifications: [
//                       Qualification(degree: 'Master', completionData: '01-01-2025'),
//                     ],
//                   );
//
//                   var response = await BaseClient().post('/users', user).catchError((err) {});
//                   if (response == null) return;
//                   debugPrint('successful:');
//                 },
//               ),
//               AppButton(
//                 operation: 'PUT',
//                 operationColor: Colors.orangeAccent,
//                 description: 'Edit user',
//                 onPressed: () async {
//                   var id = 2;
//                   var user = User(
//                     name: 'Afzal Ali',
//                     qualifications: [
//                       Qualification(degree: 'Ph.D', completionData: '01-01-2028'),
//                     ],
//                   );
//
//                   var response = await BaseClient().put('/users/$id', user).catchError((err) {});
//                   if (response == null) return;
//                   debugPrint('successful:');
//                 },
//               ),
//               AppButton(
//                 operation: 'DEL',
//                 operationColor: Colors.red,
//                 description: 'Delete user',
//                 onPressed: () async {
//                   var id = 2;
//                   var response = await BaseClient().delete('/users/$id').catchError((err) {});
//                   if (response == null) return;
//                   debugPrint('successful:');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

