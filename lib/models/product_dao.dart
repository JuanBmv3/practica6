class ProductDAO{
  String? cveProduct;
  String? descProduct;
  String? image;
  String? nombre;

  ProductDAO({this.cveProduct, this.descProduct, this.image, this.nombre});

  Map<String,dynamic> toMap(){
    return {
      'cveProduct' : cveProduct,
      'descProduct' : descProduct,
      'image' : image,
      'nombre' : nombre,
    };
  }
}