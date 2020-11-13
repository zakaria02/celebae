import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  int index;
  String imageAddress;
  String placeDetails;

  UserDetails(this.imageAddress, this.index);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserDetailsState(imageAddress, index);
  }
}

class _UserDetailsState extends State<UserDetails> {
  int index;
  String imageAddress;
  String placeDetails;

  _UserDetailsState(this.imageAddress, this.index);

  @override
  void initState() {
    super.initState();
    setState(() {
      getData(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var data = index.toString();
    print(index);
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 800.0,
                  width: double.infinity,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  height: 500.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imageAddress),
                        fit: BoxFit.fill,
                      )),
                ),
                Positioned(
                  top: 420.0,
                  left: 10.0,
                  right: 10.0,
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      height: 380.0,
                      decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(20.0)
                          ),
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 10.0,
                        top: 20.0,
                      ),
                      child: Text(
                        placeDetails,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20.0, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  getData(value) {
    placeDetails = "Description";
  }
}
