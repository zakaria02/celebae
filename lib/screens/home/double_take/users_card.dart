import 'package:flutter/material.dart';
import '../../../model/UserCard.dart';
import 'user_details.dart';

class UserCardView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserCardViewState();
  }
}

class _UserCardViewState extends State<UserCardView> {
  double _height = 0, _width = 0;
  final Color primaryColor = Color(0xFFff0e55);

  List<Widget> cardList = new List();

  void removeCards(index) {
    setState(() {
      cardList.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardList = _generateCards();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/app_bar_2.png",
          ),
          Stack(alignment: Alignment.center, children: cardList)
        ],
      ),
    );
  }

  List<Widget> _generateCards() {
    List<UserCard> planetCard = new List();
    planetCard.add(
      UserCard(
          "USER 5",
          "https://cdn.pixabay.com/photo/2015/03/03/20/42/man-657869_960_720.jpg",
          70.0),
    );
    planetCard.add(
      UserCard(
          "USER 4",
          "https://cdn.pixabay.com/photo/2014/01/03/01/13/girl-237871_960_720.jpg",
          80.0),
    );
    planetCard.add(UserCard(
        "USER 3",
        "https://cdn.pixabay.com/photo/2016/11/21/12/42/beard-1845166_1280.jpg",
        90.0));
    planetCard.add(UserCard(
        "USER 2",
        "https://cdn.pixabay.com/photo/2016/11/29/02/28/attractive-1866858_1280.jpg",
        100.0));
    planetCard.add(
      UserCard(
          "USER 1",
          "https://cdn.pixabay.com/photo/2015/09/18/11/46/man-945482_960_720.jpg",
          110.0),
    );
    List<Widget> cardList = new List();

    for (int x = 0; x < 5; x++) {
      cardList.add(
        Positioned(
          top: planetCard[x].topMargin,
          child: Draggable(
              onDragEnd: (drag) {
                removeCards(x);
              },
              childWhenDragging: Container(),
              feedback: GestureDetector(
                onTap: () {
                  print("Hello All");
                },
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // color: Color.fromARGB(250, 112, 19, 179),
                  child: Column(
                    children: <Widget>[
                      Hero(
                        tag: "imageTag",
                        child: Image.network(
                          planetCard[x].cardImage,
                          width: 320.0,
                          height: 440.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          planetCard[x].cardTitle,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.purple,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return UserDetails(planetCard[x].cardImage, x);
                  }));
                },
                child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    // color: Color.fromARGB(250, 112, 19, 179),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                            image: DecorationImage(
                                image: NetworkImage(planetCard[x].cardImage),
                                fit: BoxFit.cover),
                          ),
                          height: 500.0,
                          width: 320.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            planetCard[x].cardTitle,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.purple,
                            ),
                          ),
                        )
                      ],
                    )),
              )),
        ),
      );
    }
    return cardList;
  }
}
