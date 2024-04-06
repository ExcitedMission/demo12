import 'dart:async';
import 'dart:convert';
import 'package:api_project/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
class upto extends StatefulWidget {

  upto({Key? key,   }):super(key: key);

  @override
  State<upto> createState() => _uptoState();
}

class _uptoState extends State<upto> {
  //validation
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void validate(){
    if(formkey.currentState!.validate()){
      print("Validation Okay");
    }else{
      print('Validation error');
    }
  }

  //update data
  var userID;
  var username = '';
  var email = '';
  var mobile = '';
  var country_code = '';

  Future<void> getData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      userID = prefs.getString('userId');
      username = prefs.getString('username')??'';
      email = prefs.getString('email')??'';
      mobile = prefs.getString('mobile')??'';
      country_code = prefs.getString('country_code')??'';

      nameController.text =username.toString();
      mobileController.text =mobile.toString();
      emailController.text =email.toString();
      idController.text =userID.toString();
      CCController.text=country_code.toString();
    });

  }


  final nameController =TextEditingController();
  final emailController =TextEditingController();
  final mobileController =TextEditingController();
  final idController =TextEditingController();
  final CCController =TextEditingController();

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

        backgroundColor: Colors.greenAccent[200],
        foregroundColor: Colors.black87,
        title: Text('Update User '),
        titleSpacing: 60,

      ),
      body: SafeArea(
        child:
          Form(key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 300,
                    height: 400,
                    padding: EdgeInsets.only(bottom: 10),
                    margin: EdgeInsets.only(left: 30,right: 30,top: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.deepOrange[300],),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:[

                        Text('User Id:  $userID',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText:'Name',

                          ),
                          validator: (val){
                            if(val!.isEmpty)
                            {
                              return 'Please Enter';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText:'Email',
                          ),
                          validator: (val){
                            if(val!.isEmpty){
                              return "Required ";
                            }
                            if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val)){
                              return 'Please enter valid email';
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                          TextFormField(
                            controller: CCController,

                            decoration: InputDecoration(
                              labelText:'Coutry Code',
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
                        TextFormField(
                          controller: mobileController,
                          maxLength: 10, keyboardType: TextInputType.phone,
                          validator: (val){
                            if(val!.isEmpty)
                              {
                                return "Required";
                              }
                              else{
                                return null;
                              }
                          },
                          decoration: InputDecoration(
                            labelText:'Mobile',
                          ),
                        ),

                        SizedBox(height: 20,),
                        ElevatedButton(onPressed: (){
                          if(formkey.currentState!.validate()){
                            updata();
                          }
                        },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent[400]
                          ),
                          child: Text('Update',style: TextStyle(color: Colors.black,fontSize: 20),),
                        )
                      ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }

  void updata() async{
    try{
      Response response=await post(
          Uri.parse('https://alphawizzserver.com/jozzby_bazar_new/app/v1/api/update_user'),
          body: {
            'user_id': userID.toString(),
            'username' : nameController.text.toString(),
            'email' : emailController.text.toString(),
            'mobile' : mobileController.text.toString(),
            'country_code' : CCController.text.toString(),
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
      }
    }catch(e){
      print(e.toString());
    }
  }
}
