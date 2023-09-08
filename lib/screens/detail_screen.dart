import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_apps/utils/const.dart';
import 'package:fyp_apps/widgets/custom_clipper.dart';
import 'package:fyp_apps/widgets/grid_item.dart';
import 'package:fyp_apps/screens/home_screen.dart';
import 'package:fyp_apps/widgets/progress_vertical.dart';

class DetailScreen extends StatelessWidget {

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
                              child: Text("Hai,\nHidayatul",
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
                                Icon(
                                    Icons.calendar_today_sharp,
                                    size: 40.0,
                                    color: Constants.textPrimary
                                ),
                                SizedBox( width: 5,),

                                Text("01/07/2021",
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
               InkWell(
                 onTap: (){
                   _AlertModalBottomSheet(context);
                 },
                 child:  Container(

                   height: 500,
                   child: new GridView.builder(
                     shrinkWrap: true,
                     primary: false,
                     physics: NeverScrollableScrollPhysics(),
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: _crossAxisCount,
                       crossAxisSpacing: _crossAxisSpacing,
                       mainAxisSpacing: _mainAxisSpacing,
                       childAspectRatio: _aspectRatio,
                     ),
                     itemCount: 4,
                     itemBuilder: (BuildContext context, int index) {

                       switch(index) {
                         case 0:
                           return GridItem(
                               status: "Sebelum Makan\nSarapan",
                               time: "",
                               value: "7.6",
                               unit: "mmol/L",
                               color: Constants.darkGreen,
                               image: null,
                               remarks: "ok"
                           );
                           break;
                         case 1:
                           return GridItem(
                               status: "Selepas Makan\nSarapan",
                               time: "",
                               value: "8.2",
                               unit: "mmol/L",
                               color: Colors.redAccent,
                               image: null,
                               remarks: "ok"
                           );
                           break;
                         case 2:
                           return GridItem(
                               status: "Selepas Makan \nT.hari",
                               time: "",
                               value: "5.2",
                               unit: "mmol/L",
                               color: Constants.darkOrange,
                               image: null,
                               remarks: "ok"
                           );
                           break;
                         case 3:
                           return GridItem(
                               status: "Selepas Makan \nMalam",
                               time: "",
                               value: "12.2",
                               unit: "mmol/L",
                               color: Constants.darkBlue,
                               image: null,
                               remarks: "Ok"
                           );
                           break;
                         default:
                           return GridItem(
                             status: "Rest",
                             time: "4h 45m",
                             value: "76",
                             unit: "avg bpm",
                             image: null,
                             remarks: "ok",
                             color: Constants.darkOrange,
                           );
                           break;
                       }
                     },
                   ),
                 ),
               )
              ],
            ),
          ),
        ],
      ),
    );
  }


  _AlertModalBottomSheet(context){

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
                                child: Image.asset('assets/icons/blooddrop.png',
                                  //fit: BoxFit.contain,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                              // ),
                            ),
                            SizedBox(height:10),
                            //Text("Muat Turun Garis Panduan Kemasukan",style: new TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),


                    ),

                    SizedBox(height: 35),
                    RaisedButton(
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
