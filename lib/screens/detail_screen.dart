import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_apps/utils/const.dart';
import 'package:fyp_apps/widgets/custom_clipper.dart';
import 'package:fyp_apps/widgets/grid_item.dart';
import 'package:fyp_apps/screens/home_screen.dart';
import 'package:fyp_apps/widgets/progress_vertical.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fyp_apps/utils/function.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}


class _DetailScreenState extends State<DetailScreen> {

  var name="";
  var email="";
  var seb_sarapan="0";
  var sel_sarapan="0";
  var seb_tgh="0";
  var sel_tgh="0";
  var seb_mlm="0";
  var sel_mlm="0";
  var id_rekod="";
  var displayDate="";
  DateTime selectedDate = DateTime.now();
  TextEditingController inputGulaController = TextEditingController();


  void initState() {
    super.initState();
    //getStringData(widget.p);
    //getUserData();
    checkingCurrentSession();
  }

  checkingCurrentSession()async{


    SharedPreferences prefs = await SharedPreferences.getInstance();
    screenLoadingx(context, "Please Wait..", "Try to retrive data..", false, false, true);
    setState(() {
      //var jwtToken = prefs.getString("token");
      //name = prefs.getString("localname").toString();
      email = prefs.getString("localemail").toString();
    });
    //logPrintOut("home:line 44");
    //logPrintOut("checking current session..");
    Navigator.pop(context);
    getUserData(email);

  }


  getUserData(paramemail)async{
    screenLoadingx(context, "Please Wait..", "Try to retrive data..", false, false, true);

    var dataP={"email":paramemail};
    if (this.mounted) {
      var dataReturn= await fetchData("fetchData","users",dataP);
      print("00000000");
      print(dataReturn);
      // if(){}
      setState(() {
        name=dataReturn[0]['name'] ?? "";
      });
    }
    Navigator.pop(context);
    getRekodData(paramemail,formatDate(selectedDate));

  }

  getRekodData(paramemail,paramdate)async{
    screenLoadingx(context, "Please Wait..", "Try to comunicate with server..", false, false, true);
    var dataX={
      "email":paramemail,
      "tarikh_rekod":paramdate
    };

    if (this.mounted) {
      var dataReturn= await fetchData("fetchData","callrekod",dataX);
      print("00000000");
      print(dataReturn);
       if(dataReturn.length>0){
         print(dataReturn.length);
         setState(() {
           id_rekod=dataReturn[0]['id_rekod'];
           displayDate=paramdate;
           seb_sarapan=dataReturn[0]['seb_sarapan'] ?? "0";
           sel_sarapan=dataReturn[0]['sel_sarapan'] ?? "0";
           seb_tgh=dataReturn[0]['seb_tgh'] ?? "0";
           sel_tgh=dataReturn[0]['sel_tgh'] ?? "0";
           seb_mlm=dataReturn[0]['seb_mlm'] ?? "0";
           sel_mlm=dataReturn[0]['sel_mlm'] ?? "0";
         });
         Navigator.of(context, rootNavigator: true).pop();
       }else{
         setState(() {
           id_rekod="";
           displayDate=paramdate;
           seb_sarapan="";
           sel_sarapan="";
           seb_tgh="";
           sel_tgh="";
           seb_mlm="";
           sel_mlm="";
         });
         Navigator.of(context, rootNavigator: true).pop();
       }

    }


  }

   insertRekodData(context,inputGula,id_rekod,jenisC,dateS)async{
    screenLoadingx(context, "Please Wait..", "Try to add new record..", false, false, true);
    var dataX={
      "selectedDate":dateS,
      "inputGula":inputGula,
      "id_rekod":id_rekod,
      "jenisC":jenisC
    };
    print("oopoopooo");
    print(dataX);

    if (this.mounted) {
      var dataReturn= await fetchData("fetchData","insertrekod",dataX);
      if(dataReturn['status']=="0"){
        Navigator.pop(context);
        Navigator.pop(context);
        await getRekodData(email,dateS);

       // Navigator.pop(context);
        //await checkingCurrentSession();
        //screenLoadingx(context, "Info", dataReturn['message'], true, false, false);
        //Navigator.pop(context);
       // await prefs.setString('token', rawData['token']);
        //Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const MaanHome()), (route) => false);
      }else{
        Navigator.of(context, rootNavigator: true).pop();
        screenLoadingx(context, "Opss..", dataReturn['message'], true, false, false);

      }
      print("00000000");
      print(dataReturn);
      /*if(dataReturn.length>0){
        print(dataReturn.length);
        setState(() {
          id_rekod=dataReturn[0]['id_rekod'];
          seb_sarapan=dataReturn[0]['seb_sarapan'] ?? "0";
          sel_sarapan=dataReturn[0]['sel_sarapan'] ?? "0";
          seb_tgh=dataReturn[0]['seb_tgh'] ?? "0";
          sel_tgh=dataReturn[0]['sel_tgh'] ?? "0";
          seb_mlm=dataReturn[0]['seb_mlm'] ?? "0";
          sel_mlm=dataReturn[0]['sel_mlm'] ?? "0";
        });
        Navigator.of(context, rootNavigator: true).pop();
      }
      else{
        setState(() {
          id_rekod="";
          seb_sarapan="";
          sel_sarapan="";
          seb_tgh="";
          sel_tgh="";
          seb_mlm="";
          sel_mlm="";
        });
        Navigator.of(context, rootNavigator: true).pop();
      }*/

    }


  }



  updateRekodData(context,inputGula,id_rekod,jenisC,dateS)async{
    screenLoadingx(context, "Please Wait..", "Try to update data..", false, false, true);
    var dataX={
      "selectedDate":dateS,
      "inputGula":inputGula,
      "id_rekod":id_rekod,
      "jenisC":jenisC
    };
    print("oopoopooo");
    print(dataX);

    if (this.mounted) {
      var dataReturn= await fetchData("fetchData","updaterekod",dataX);
      if(dataReturn['status']=="0"){
        Navigator.pop(context);
        Navigator.pop(context);
        await getRekodData(email,dateS);


       //await checkingCurrentSession();
        //screenLoadingx(context, "Info", dataReturn['message'], true, false, false);

       // Navigator.pop(context);
        // await prefs.setString('token', rawData['token']);
        //Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const MaanHome()), (route) => false);
      }else{

        screenLoadingx(context, "Opss..", dataReturn['message'], true, false, false);

      }
      print("00000000");
      print(dataReturn);
      /*if(dataReturn.length>0){
        print(dataReturn.length);
        setState(() {
          id_rekod=dataReturn[0]['id_rekod'];
          seb_sarapan=dataReturn[0]['seb_sarapan'] ?? "0";
          sel_sarapan=dataReturn[0]['sel_sarapan'] ?? "0";
          seb_tgh=dataReturn[0]['seb_tgh'] ?? "0";
          sel_tgh=dataReturn[0]['sel_tgh'] ?? "0";
          seb_mlm=dataReturn[0]['seb_mlm'] ?? "0";
          sel_mlm=dataReturn[0]['sel_mlm'] ?? "0";
        });
        Navigator.of(context, rootNavigator: true).pop();
      }
      else{
        setState(() {
          id_rekod="";
          seb_sarapan="";
          sel_sarapan="";
          seb_tgh="";
          sel_tgh="";
          seb_mlm="";
          sel_mlm="";
        });
        Navigator.of(context, rootNavigator: true).pop();
      }*/

    }


  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light( primary: Constants.darkGreen,),
            // Change the primary color
           // accentColor: Colors.blue, // Change the accent color
            dialogBackgroundColor: Colors.white, // Change the background color
            textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.red), // Change text selection color
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              buttonColor: Colors.green, // Change button color
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        displayDate=formatDate(selectedDate);
      });
      getRekodData(email,formatDate(selectedDate));
    }
  }



  /*Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),


    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }*/

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    // For Grid Layout
    double _crossAxisSpacing = 16, _mainAxisSpacing = 16, _cellHeight = 150.0;
    int _crossAxisCount = 2;

    double _width = (MediaQuery.of(context).size.width -
        ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    double _aspectRatio =
        _width / (_cellHeight + _mainAxisSpacing + (_crossAxisCount + 1));

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Constants.darkGreen,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),

          Positioned(
              right: -45,
              top: -30,
              child: ClipOval(
                  child: Container(
                    color: Colors.black.withOpacity(0.05),
                    height: 220,
                    width: 220,
                  ),
              ),
          ),

          // BODY
          Padding(
            padding: EdgeInsets.all(15),

            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Back Button
                      /*  SizedBox(
                          width: 34,
                          child:RawMaterialButton(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                                Icons.arrow_back_ios,
                                size: 15.0,
                                color: Colors.white
                            ),
                            shape: CircleBorder(
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                    style: BorderStyle.solid
                                ),
                            ),
                          ),
                        ),*/
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              child: Text("Hai,\n ${name}",
                              style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.white
                              ),
                              ),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomeScreen()),
                                );
                              },
                            ),

                            SizedBox(height: 10),
                           /* Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              mainAxisAlignment: MainAxisAlignment.start,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text("66",
                                    style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white
                                    ),
                                ),

                                SizedBox(width: 10),

                                Text("bpm",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                    ),
                                ),
                              ],
                            )*/
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Image(
                      fit: BoxFit.cover,
                        image: AssetImage('assets/icons/6023510.png'),
                        height: 73,
                        width: 80,
                        color: Colors.white.withOpacity(1)
                    ),
                  ],
                ),
                SizedBox(height: 40),
                // Chart
                //Material(
                  //shadowColor: Colors.grey.withOpacity(0.01), // added
                  //type: MaterialType.card,
                  //elevation: 10, borderRadius: new BorderRadius.circular(10.0),
                   Container(
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(10.0),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(3, 3), // changes position of shadow
                        ),
                      ],
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                    ),
                    //height: 200,
                    child: Column(

                      children: [


                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("BACAAN GULA ANDA PADA :",
                              style: TextStyle(
                                color: Constants.textPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15,


                        ),

                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap:(){
                                    _selectDate(context);
                                  },
                                  child: Icon(
                                      Icons.calendar_today_sharp,
                                      size: 40.0,
                                      color: Constants.textPrimary
                                  ),
                                ),
                                SizedBox( width: 5,),

                                Text('${displayDate}',
                                  style: TextStyle(
                                    color: Constants.textPrimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), // added
                //),

                SizedBox(height:20),
              // InkWell(

                 Container(

                   height: 500,
                   child:  GridView.builder(
                     shrinkWrap: true,
                     primary: false,
                     physics: NeverScrollableScrollPhysics(),
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: _crossAxisCount,
                       crossAxisSpacing: _crossAxisSpacing,
                       mainAxisSpacing: _mainAxisSpacing,
                       childAspectRatio: _aspectRatio,
                     ),
                     itemCount: 6,
                     itemBuilder: (BuildContext context, int index) {

                       switch(index) {
                         case 0:
                           return InkWell(
                             onTap: (){
                               _AlertModalBottomSheet(context,index,seb_sarapan);
                             },
                             child: GridItem(
                                 status: "Sebelum Makan\nSarapan",
                                 time: "",
                                 value: "${seb_sarapan}",
                                 unit: "mmol/L",
                                 color: Constants.darkGreen,
                                 image: "",
                                 remarks: "ok"
                             ),
                           );
                           break;
                         case 1:
                           return InkWell(
                             onTap: (){
                               _AlertModalBottomSheet(context,index,sel_sarapan);
                             },
                             child: GridItem(
                                 status: "Selepas Makan\nSarapan",
                                 time: "",
                                 value: "${sel_sarapan}",
                                 unit: "mmol/L",
                                 color: Colors.redAccent,
                                 image: "",
                                 remarks: "ok"
                             ),
                           );
                           break;
                         case 2:
                           return InkWell(
                             onTap: (){
                               _AlertModalBottomSheet(context,index,seb_tgh);
                             },
                             child: GridItem(
                                 status: "Sebelum Makan \nT.hari",
                                 time: "",
                                 value: "${seb_tgh}",
                                 unit: "mmol/L",
                                 color: Constants.darkOrange,
                                 image: "",
                                 remarks: "ok"
                             ),
                           );
                           break;
                         case 3:
                           return InkWell(
                             onTap: (){
                               _AlertModalBottomSheet(context,index,sel_tgh);
                             },
                             child: GridItem(
                                 status: "Selepas Makan \nT.hari",
                                 time: "",
                                 value: "${sel_tgh}",
                                 unit: "mmol/L",
                                 color: Constants.darkBlue,
                                 image: "",
                                 remarks: "Ok"
                             ),
                           );
                         case 4:
                           return InkWell(
                             onTap: (){
                               _AlertModalBottomSheet(context,index,seb_mlm);
                             },
                             child: GridItem(
                                 status: "Sebelum Makan \nMalam",
                                 time: "",
                                 value: "${seb_mlm}",
                                 unit: "mmol/L",
                                 color: Constants.darkBlue,
                                 image: "",
                                 remarks: "Ok"
                             ),
                           );
                         case 5:
                           return InkWell(
                             onTap: (){
                               _AlertModalBottomSheet(context,index,sel_mlm);
                             },
                             child: GridItem(
                                 status: "Selepas Makan \nMalam",
                                 time: "",
                                 value: "${sel_mlm}",
                                 unit: "mmol/L",
                                 color: Constants.darkBlue,
                                 image: "",
                                 remarks: "Ok"
                             ),
                           );
                           break;
                         default:
                           return GridItem(
                             status: "Rest",
                             time: "4h 45m",
                             value: "76",
                             unit: "avg bpm",
                             image: "",
                             remarks: "ok",
                             color: Constants.darkOrange,
                           );
                           break;
                       }
                     },
                   ),

                 ),
                 /*onTap: (){
                  // int tappedIndex = DefaultTabController.of(context)!.index;
                   _AlertModalBottomSheet(context);
                 },*/
               //),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ],
      ),
    );
  }


  _AlertModalBottomSheet(context,jenisC,oldV){
    setState(() {
      inputGulaController.text=oldV;
    });

    showModalBottomSheet(

      barrierColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
            //decoration: BoxDecoration(color:umtColor),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),

            child: Padding(
              padding: const EdgeInsets.all(5.0), // content padding
              child: Container(
                margin: EdgeInsets.only(top:50,left: 5,right: 5,bottom: 15),//EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                height: MediaQuery.of(context).size.height/2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0xFFE5E5E5),
                  ),
                ),
                child:Column(
                  children: [
                    Container(
                      child: Text("Masukkan bacaan gula anda ",style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0,),),
                    ),
                    SizedBox(height:25),
                    Expanded(
                      child:
                      InkWell(
                        onTap: (){

                        },
                        child: Column(
                          children: [
                            Container(
                              //height: double.infinity,
                              alignment: Alignment.center, // This is needed
                              //child: InkWell(

                              child: Center(
                                child:TextField(
                                  controller: inputGulaController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelStyle: TextStyle(
                                        color: Colors.black
                                    ),
                                    labelText: 'Bacaan gula mmol/L',
                                  ),
                                ),
                                /*Image.asset('assets/icons/blooddrop.png',
                                  //fit: BoxFit.contain,
                                  height: 80,
                                  width: 80,
                                ),*/
                              ),

                              // ),
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Constants.darkGreen,),
                                onPressed: () async{

                                  final inputGula = inputGulaController.text;
                                  print("vvvvvvvv");
                                  print(id_rekod);
                                  print("vvvvvvvv");
                                  if(id_rekod!=""){
                                   // if (this.mounted) {
                                     await updateRekodData(context,inputGula,id_rekod,jenisC,formatDate(selectedDate));
                                    /*}else{
                                      Navigator.of(context).pop();
                                    }*/


                                  }
                                  else{
                                    print("masuk add rekod");
                                    await  insertRekodData(context,inputGula,id_rekod,jenisC,formatDate(selectedDate));

                                  }

                                },
                                child: Text('Submit',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            SizedBox(height:10),
                            //Text("Muat Turun Garis Panduan Kemasukan",style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),


                    ),

                    SizedBox(height: 35),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                      child: Text(
                        "Tutup",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () {
                        Navigator.pop(context);

                        //function();
                      },
                    ),
                  ],

                ),

              ),


            )
        );
      },
    );
  }
}
