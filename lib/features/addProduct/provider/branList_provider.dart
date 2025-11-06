import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BrandListProvider with ChangeNotifier {
  List<String> branlist = [];
  String? slectedbrand;
  bool isloading = true;

  BrandListProvider() {
    // Auto-fetch when provider is first created
    fetchBrands();
  }

  Future<void> fetchBrands() async {
    try {
      isloading = true;
      notifyListeners();

      final snapshot = await FirebaseFirestore.instance.collection('brand').get();
      branlist = snapshot.docs.map((doc) => doc['brandName'] as String).toList();
  print("Fetched brands: $branlist");

      isloading = false;
      notifyListeners();
    } catch (e) {
      print("🔥 Error fetching brands: $e");
      isloading = false;
      notifyListeners();
    }
  }

  void selectingBrand(String brand) {
    slectedbrand = brand;
    notifyListeners();
  }
}
