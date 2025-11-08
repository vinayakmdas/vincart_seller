import 'package:ecommerce_seller/features/addProduct/model/variant_model.dart';
import 'package:flutter/material.dart';

class VariantProvider extends ChangeNotifier {
    final List<VariantModel> _variants = [];
  List<VariantModel> get variants => _variants;

  void addVariant(VariantModel variant) {
    _variants.add(variant);
    notifyListeners();
  }

  void removeVariant(int index) {
    _variants.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _variants.clear();
    notifyListeners();
  }
}