import 'package:dio/dio.dart';
import 'url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<void> screenLoadingx(BuildContext context, title, desc, bool isclose,
    bool overlay, bool spin) async {
  Alert(
      context: context,
      title: title,
      //desc: desc,
      content: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: spin == true
            ? Column(
          children: [
            Image.asset(
              "assets/icons/loading.gif",
              height: 200.0,
              width: 200.0,
            ),
            //Text(title,style:TextStyle(fontFamily: 'raleway', fontWeight: FontWeight.bold)),
            Text(desc,style:TextStyle(fontFamily: 'raleway', fontSize: 15.0)),
          ],
        )
            : Center(child: Text(desc,style:TextStyle(fontFamily: 'raleway', fontSize: 15.0)),),
      ),
      style: AlertStyle(
          isCloseButton: isclose,
          isOverlayTapDismiss: overlay,
          titleStyle:
          TextStyle(fontFamily: 'raleway', fontWeight: FontWeight.bold),
          descStyle: TextStyle(fontFamily: 'raleway', fontSize: 15.0),
          alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))),
      buttons: []).show();
}

logInAccess(context,endpoint,ParamData) async {
  screenLoadingx(context, "Please Wait..", "Checking authentication from server..", false, false, true);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("cccccccc");
  print(ParamData);
  print("cccccccc");
  //final dio = Dio();
  final dioOptions = BaseOptions(
    baseUrl: API_URL,
  );

  final dioClient = Dio(dioOptions);

  try {
    final response = await dioClient.get(
      endpoint+".php",
      data: ParamData,
    );

    var rawData = json.decode(response.toString());
    if (response.statusCode == 200) {
      Navigator.of(context, rootNavigator: true).pop();
      if(rawData['status']=="0"){
        print("masuk");
        print(rawData);
        await prefs.setString('token', rawData['token']);
        await prefs.setString('localemail', rawData['email']);
       // await prefs.setString('localname', rawData['name']);
        Navigator.of(context).pushNamedAndRemoveUntil('/coreHome', (Route<dynamic> route) => false);
        //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const MaanHome()), (route) => false);
      }else{
        screenLoadingx(context, "Opss..", rawData['message'], true, false, false);

      }
      // Handle successful response
      //await prefs.setString('action', 'Start');
      print(rawData);
    } else {
      // Handle non-200 status codes here
      print('Request failed with status: ${response.statusCode}');
      print('Error message: ${response.statusMessage}');
    }
  } catch (e) {
    // Handle network errors and Dio exceptions
    print('Error: $e');
  }
}


fetchData(action,endpoint,ParamData) async {
  final dio = Dio();

  // Replace 'YOUR_BEARER_TOKEN' with your actual Bearer token
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? bearerToken = preferences.getString("token");
  String? localemail = preferences.getString("localemail");
  //final bearerToken = 'YOUR_BEARER_TOKEN';
  ParamData['localemail'] = localemail;
  //ParamData.add({"localemail": localemail});

  print("yyyyy");
  print(ParamData);

  final dioOptions = BaseOptions(
    baseUrl: API_URL, // Replace with your API base URL
    headers: {'Authorization': 'Bearer $bearerToken',},
  );

  final dioClient = Dio(dioOptions);

  try {
    //final response = await dioClient.get('/some-endpoint');
    final response = await dioClient.get(
      endpoint+".php",
      data: ParamData,
    );
    var rawData = json.decode(response.toString());
    if (response.statusCode == 200) {
      // Handle successful response
      print('Response Data: ${response.data}');
      return rawData;

    } else {
      // Handle non-200 status codes here
      print('Request failed with status: ${response.statusCode}');
      print('Error message: ${response.statusMessage}');
    }
  } catch (e) {
    // Handle network errors and Dio exceptions
    print('Error: $e');
  }
}


signUpAccess(context,endpoint,ParamData) async {
  screenLoadingx(context, "Please Wait..", "Verify data to server..", false, false, true);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("cccccccc");
  print(ParamData);
  print("cccccccc");
  //final dio = Dio();
  final dioOptions = BaseOptions(
    baseUrl: API_URL,
  );

  final dioClient = Dio(dioOptions);

  try {
    final response = await dioClient.get(
      endpoint+".php",
      data: ParamData,
    );

    var rawData = json.decode(response.toString());
    if (response.statusCode == 200) {
      Navigator.of(context, rootNavigator: true).pop();
      if(rawData['status']=="0"){
        screenLoadingx(context, "Info", rawData['message'], true, false, false);
        await prefs.setString('token', rawData['token']);
         Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const MaanHome()), (route) => false);
      }else{
        screenLoadingx(context, "Opss..", rawData['message'], true, false, false);

      }
      // Handle successful response
      //await prefs.setString('action', 'Start');
      print(rawData);
    } else {
      // Handle non-200 status codes here
      print('Request failed with status: ${response.statusCode}');
      print('Error message: ${response.statusMessage}');
    }
  } catch (e) {
    // Handle network errors and Dio exceptions
    print('Error: $e');
  }
}
