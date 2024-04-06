import 'dart:convert';

import 'package:api_project/addData.dart';
import 'package:api_project/home.dart';
import 'package:api_project/splace.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _PostsState();
}

class _PostsState extends State<login> {
  TextEditingController mobile=TextEditingController();
  TextEditingController password=TextEditingController();

  void login1() async{
    try{
      Response response=await post(
          Uri.parse('https://alphawizzserver.com/jozzby_bazar_new/app/v1/api/login'),
          body: {
            'mobile' : mobile.text.toString(),
            'password' : password.text.toString(),
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        if(data['error']==false){

          Fluttertoast.showToast(
              msg: "${data["message"]}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          setState(() {

            var useiddd=data['data'][0]['id'];
            var username=data['data'][0]['username'];
            print(username);
            var email=data['data'][0]['email'];
            print(email);
            var mobile=data['data'][0]['mobile'];
            print(mobile);
            var country_code=data['data'][0]['country_code'];
            print(country_code);
            setData(useiddd,username, email, mobile, country_code);
          });
          print(' Account login successfully');

          var sharedPref = await SharedPreferences.getInstance();
          sharedPref.setBool(splaceState.KEYLOGIN, true);

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
              homePage(),));
        }
        else{
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
        print('Failed');
      }
    }catch(e){
      print(e.toString());
    }
  }
  //validation
  GlobalKey<FormState> formkey=GlobalKey<FormState>();
  void validate(){
    if(formkey.currentState!.validate()){
      print("ok");
    }else{
      print("Error Please enter proper details");
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[200],
        foregroundColor: Colors.black,
        title: Center(child: Text('LOG-IN         ',style: TextStyle(fontWeight: FontWeight.bold),)),
      ),

      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 30,right: 30),
              child: SingleChildScrollView(
                child: Form(key: formkey,
                  child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Icon(
                          Icons.account_circle_sharp,
                          color: Colors.black87,
                          size: 120,
                        ),
                        Text('Welcome',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(height: 30,),
                        Text('Enter Mobile & Password -',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        //mobile
                        TextFormField(
                          controller: mobile,
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'mobile',
                            labelText: 'mobile',
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
                        SizedBox(height: 10,),
                        //password
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.password,color: Colors.black54,),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.greenAccent)
                            ),
                            suffixIconColor: MaterialStateColor.resolveWith((states) =>
                            states.contains(MaterialState.focused)
                                ? Colors.black
                                : Colors.black54),
                            //labelText: "Password",
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
                            //labelStyle: TextStyle(color: Colors.black),
                            //prefixIcon: Icon(Icons.lock),
                            prefixIconColor: Colors.black54,
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

                        GestureDetector(
                          onTap: (){
                            validate();
                            login1();
                          },
                          child: Container(height: 50,
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(' LOGIN ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ),
                          ),
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>addData()));
                        },
                            child: Text('SIGN-UP',style:
                            TextStyle(fontSize: 16,decoration: TextDecoration.underline,color: Colors.black54),))

                      ]
                  ),
                ),
              ),


            ),
          ),
        ],
      ),
    );
  }
  Future<void> setData(String idd,String username,String email,String mobile,String country_code,)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userId', idd);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('mobile', mobile);
    await prefs.setString('country_code', country_code);

  }
}












// import 'package:json_annotation/json_annotation.dart';
// part 'model.g.dart';
//
// @JsonSerializable()
// class Model{
//   String name;
//   String phonenumber;
//   Model({required this.name,required this.phonenumber});
//   factory Model.fromJson(Map<String.dynamic> json)=> _$ModelFromJson(json);
//   Map<String, dynamic> toJson()=> _$ModelToJson(this);
// }




// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// const String baseUrl='https://reqres.in/api/register';
// class BaseClient{
//   var client = http.Client();
//   Future<dynamic> get(String api) async {
//     var url = Uri.parse(baseUrl + api);
//     var _headers = {
//       'id':'4',
//       'token': 'QpwL5tke4Pnpja7X4',
//       //'Authorization': 'Bearer sfie328370428387=',
//
//     };
//
//     var response = await client.get(url, headers: _headers);
//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       //throw exception and catch it in UI
//     }
//   }
//
//   Future<dynamic> post(String api, dynamic object) async {
//     var url = Uri.parse(baseUrl + api);
//     var _payload = json.encode(object);
//     var _headers = {
//       // 'Authorization': 'Bearer sfie328370428387=',
//       // 'Content-Type': 'application/json',
//       // 'api_key': 'ief873fj38uf38uf83u839898989',
//       'id':'4',
//       'token': 'QpwL5tke4Pnpja7X4',
//     };
//
//     var response = await client.post(url, body: _payload, headers: _headers);
//     if (response.statusCode == 201) {
//       return response.body;
//     } else {
//       //throw exception and catch it in UI
//     }
//   }
//
//   ///PUT Request
//   Future<dynamic> put(String api, dynamic object) async {
//     var url = Uri.parse(baseUrl + api);
//     var _payload = json.encode(object);
//     var _headers = {
//       // 'Authorization': 'Bearer sfie328370428387=',
//       // 'Content-Type': 'application/json',
//       // 'api_key': 'ief873fj38uf38uf83u839898989',
//       'id':'4',
//       'token': 'QpwL5tke4Pnpja7X4',
//     };
//
//     var response = await client.put(url, body: _payload, headers: _headers);
//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       //throw exception and catch it in UI
//     }
//   }
//
//   Future<dynamic> delete(String api) async {
//     var url = Uri.parse(baseUrl + api);
//     var _headers = {
//       // 'Authorization': 'Bearer sfie328370428387=',
//       // 'api_key': 'ief873fj38uf38uf83u839898989',
//       'id':'4',
//       'token': 'QpwL5tke4Pnpja7X4',
//     };
//
//     var response = await client.delete(url, headers: _headers);
//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       //throw exception and catch it in UI
//     }
//   }
// }
