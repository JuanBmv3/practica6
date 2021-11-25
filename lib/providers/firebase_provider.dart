import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica6/models/product_dao.dart';


class FirebaseProvider{

  late FirebaseFirestore _firestore;
  late CollectionReference _productsCollection;

  FirebaseProvider(){
    _firestore = FirebaseFirestore.instance;
    _productsCollection = _firestore.collection('products');
  }

  Future<void> saveProduct(ProductDAO objDAO){
    return _productsCollection.add(objDAO.toMap());
  }

  Future<void> updateProduct(ProductDAO objDAO, String DocumentID){
    return _productsCollection.doc(DocumentID).update(objDAO.toMap());

  }

  Future<void> deleteProduct(String DocumentID){
    return _productsCollection.doc(DocumentID).delete();
  }

  Stream<QuerySnapshot> getAllProducts(){
    return _productsCollection.snapshots();
  }

}