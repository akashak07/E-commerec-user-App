import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("Products",style: TextStyle(color: Colors.black,)  ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Stack(
                children: [

                  Container(
                    // child:Image.network(image())
                  child: Image.network('https://firebasestorage.googleapis.com/v0/b/ecommerce-ba53d.appspot.com/o/images%2FimageName?alt=media&token=795edd2d-0a5b-479a-9b57-86e0e672c124 '),
                ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: MaterialButton(
                          onPressed: () {},
                          color: Colors.white,
                          textColor: Colors.white,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.grey,
                            size: 24,
                          ),
                          padding: EdgeInsets.all(16),
                          shape: CircleBorder(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: MaterialButton(
                            onPressed: () {},
                            color: Colors.white,
                            textColor: Colors.white,
                            child: Icon(
                              Icons.share,
                              color: Colors.grey,
                              size: 24,
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
              ]
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
               children: [Text("Eyevy",style: TextStyle(fontSize: 20,color: Colors.grey),),]
             ),
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text("Full Rim Round,Cat eyed Anti-glare Frame(48mm)",
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 20,color: Colors.grey,),),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("₹219",style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 25)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text("₹̶9̶9̶9̶",style:TextStyle(color: Colors.grey,fontSize: 25)),
                  ),
                  Text("78% off",style:TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 25)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    color: Colors.white,
                    child: Text('Add to Cart',style: TextStyle(color: Colors.black,),),
                    onPressed: () {
                      setState(() {
                      });
                    },
                  ),
                  FlatButton(
                    color: Colors.orangeAccent,
                    child: Text('Buy Now',style: TextStyle(color: Colors.white,),),
                    onPressed: () {
                      setState(() {
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}

