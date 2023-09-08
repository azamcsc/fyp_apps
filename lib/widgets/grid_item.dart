import 'package:flutter/material.dart';
import 'package:fyp_apps/utils/const.dart';

class GridItem extends StatelessWidget {
  final String status;
  final String time;
  final String value;
  final String unit;
  final ImageProvider image;
  final Color color;
  final String remarks;

  GridItem({
    Key key,
    @required this.status,
    @required this.value,
    @required this.unit,
    @required this.time,
    @required this.image,
    @required this.remarks,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
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
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    status,
                    style: TextStyle(
                        fontSize: 18,
                        color: Constants.textPrimary,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              (image == null)
                  ? Column(
                      children: <Widget>[
                        Text(
                          value,
                          style: TextStyle(
                              fontWeight:
                              FontWeight.w900,
                              fontSize: 35,
                              color: color
                          ),
                        ),
                        Text(
                          unit,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Image(
                          image: image,
                        ),
                        Text(
                          remarks,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
    );
  }
}
