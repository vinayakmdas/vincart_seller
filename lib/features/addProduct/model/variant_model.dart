class VariantModel {

final Map<String, String> selectedOptions;
final String size;
final String color;
final  List<String>images ;
final num price;
 final int quantity;

  VariantModel({
    required this.selectedOptions,
    required this.size,
    required this.color,
    required this.images,
    required this.price,
    required this.quantity,
  });


Map<String , dynamic>toJson(){

  return {
    'selectedOptions':selectedOptions,
    'size':size,
    'colro':color,
    'images':images,
    'price':price,
    'quantity':quantity,
  };
}

}