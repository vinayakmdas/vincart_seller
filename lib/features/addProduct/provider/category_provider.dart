import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller/features/addProduct/model/attriburtes_model.dart';
import 'package:ecommerce_seller/features/addProduct/model/category_model.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {

  List<CategoryModel> _categoryList = [];
  List<AttriburtesModel> _attributes = [];

  List<CategoryModel> get categoryList => _categoryList;
  List<AttriburtesModel> get attributes => _attributes;


  List<AttriburtesModel> selectedAttributes = [];
  Map<String, String> selectedOptions = {}; // attrId -> option

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchCategories() async {
    final snapshot = await _firestore.collection('category').get();
    _categoryList = snapshot.docs
        .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
        .toList();
    notifyListeners();
  }

  
  Future<void> fetchAttributesForCategory(CategoryModel category) async {
  _attributes.clear(); // Clear old data first
  notifyListeners();

  try {
    for (String attrId in category.requiredAttributes) {
      final doc = await _firestore.collection('attributes').doc(attrId).get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        _attributes.add(AttriburtesModel.fromMap(data, doc.id));
      }
    }

    notifyListeners();
  } catch (e) {
    debugPrint("Error fetching attributes: $e");
  }
}



  void selectOption(String attrId, String option) {
    selectedOptions[attrId] = option;
    notifyListeners();
  }

  void clearSelections() {
    selectedAttributes = [];
    selectedOptions.clear();
    notifyListeners();
  }
}
