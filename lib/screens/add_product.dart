import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:practica6/models/product_dao.dart';
import 'package:practica6/providers/firebase_provider.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  File? _image;

  TextEditingController _cveController = new TextEditingController();
  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _descController = new TextEditingController();
  bool mensajeC = false;
  bool mensajeN = false;
  bool mensajeD = false;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title:  Text("Add Product", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 15),
              child: _image == null
                  ? null
                  :  ElevatedButton.icon(
                  icon: Icon(Icons.check),
                  label: Text('Añadir'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                    setState(() {
                      
                        if (_cveController.text.isEmpty) {
                        mensajeC = true;
                      } else {
                        mensajeC = false;

                        if (_nombreController.text.isEmpty) {
                          mensajeN = true;
                        } else {
                          mensajeN = false;

                          if (_descController.text.isEmpty) {
                            mensajeD = true;
                          } else {
                            mensajeD = false;

                            uploadImage();
                            Navigator.pop(context);
                          }
                        }
                      }

                    });      
                  }
              )
            )
          ]  
        ),
      body: Center(
        child: _image == null
        ? Text("Primero elige una imagen para guardar el producto", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15))
        : formProduct(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getImage();
        },
        tooltip: "Add Image",
        child: Icon(Icons.add_a_photo, color: Colors.white)
      ),
    );
  }

  Future getImage() async{
     final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(_image == null) return;
    
    final imageTemporary = File(_image.path);
    setState(() {
       this._image = imageTemporary;
      
    });
    
  }

  Widget formProduct(){
    
      return Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(
                _image!,
                height: 400,
                fit: BoxFit.fill
              ),
            ),Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextFormField(
                controller:_cveController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  labelText: 'Clave',
                  suffixIcon: Icon(Icons.qr_code),
                  errorText: mensajeC ? 'Este campo es obligatorio' : null
                ),
               
               ),
             ),
            
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                controller:_nombreController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  labelText: 'Nombre',
                  suffixIcon: Icon(Icons.create),
                  errorText: mensajeN ? 'Este campo es obligatorio' : null
                ),
                
            ),
              ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextFormField(
                controller:_descController,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  labelText: 'Agrega  una descipcion',
                  suffixIcon: Icon(Icons.description),
                  errorText: mensajeD ? 'Este campo es obligatorio' : null
                ),
               
               ),
             )
    
          ],
        )
      );
  }

  void uploadImage() async{
   final imageName = basename(_image!.path);
   print(imageName);
   /*final url =  'Images/$imageName';*/

   Reference postImageRef = FirebaseStorage.instance.ref().child("Images");
   final UploadTask uploadTask = postImageRef.child(imageName).putFile(_image!);
   var imageUrl = await (await uploadTask).ref.getDownloadURL();
   String url = imageUrl.toString();
   
   addProduct(url);


   
  }

  void addProduct(String url) {
    ProductDAO producto = ProductDAO(
      cveProduct: _cveController.text,
      descProduct: _descController.text,
      image: url,
      nombre: _nombreController.text
    );

    FirebaseProvider firebase_provider = FirebaseProvider();

    firebase_provider.saveProduct(producto);
  }
}
