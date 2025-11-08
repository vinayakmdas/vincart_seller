class VariantModel {

final Map<String, String> selectedOptions;
final String size;
final String color;
final  List<String>images ;
final num regularPrise;
final num price;
 final int quantity;

  VariantModel({
    required this.selectedOptions,
    required this.size,
    required this.color,
    required this.images,

    required this.regularPrise,
    required this.price,
    required this.quantity,
  });


Map<String , dynamic>toJson(){

  return {
    'selectedOptions':selectedOptions,
    'size':size,
    'colro':color,
    'images':images,
    'regularPrise':regularPrise,
    'price':price,
    'quantity':quantity,
  };
}

}