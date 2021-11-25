import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica6/providers/firebase_provider.dart';
import 'package:practica6/views/card_product.dart';


class ListProducts extends StatefulWidget {
  ListProducts({Key? key}) : super(key: key);

  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  
  late FirebaseProvider _firebaseProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseProvider = FirebaseProvider();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, color: Colors.black),
            SizedBox(width:10),
            Text("Products APP", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
        actions:[
          IconButton(
          onPressed : (){
            Navigator.pushNamed(context, '/agregar').whenComplete(
              (){ setState(() {
                                
                });
              }
            );
          },
          icon: Icon(Icons.add_to_photos, color: Colors.orange[800], size: 25),

          ),
        ],
        centerTitle: true,
      ),
  
      body: StreamBuilder(
          stream: _firebaseProvider.getAllProducts(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
    
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document){
                return CardProduct(productDocument: document);
              }).toList(),
            );
          }
        ),
    );
  }
}