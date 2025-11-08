import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class VariationCustomeProvider extends ChangeNotifier {
  final TextEditingController qtyCtrl = TextEditingController();
  final TextEditingController regularPrise = TextEditingController();
  final TextEditingController salePrise = TextEditingController();

  final Map<String, String> selectedOptions = {};
  final List<String> imagesUrl = []; // ✅ store Cloudinary URLs
  final List<PlatformFile> images = [];


  static const String cloudName = 'logocloudname';
  static const String uploadPreset = 'Product_preset';


  void selectOption(String attrId, String option) {
    selectedOptions[attrId] = option;
    notifyListeners();
  }

  Future<void> pickSingleImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;
      images.add(file);
      notifyListeners();

  
      final url = await _uploadToCloudinary(file);

      print("Uploaded Image URL: $url");
      if (url != null) {
        imagesUrl.add(url);
        notifyListeners();
      }
    }
  }


  Future<String?> _uploadToCloudinary(PlatformFile file) async {
    try {
      final uploadUrl = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

      final request = http.MultipartRequest("POST", uploadUrl)
        ..fields['upload_preset'] = uploadPreset;

      if (kIsWeb) {
      
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          file.bytes!,
          filename: file.name,
        ));
      } else {
       
        request.files.add(await http.MultipartFile.fromPath('file', file.path!));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);
        return data["secure_url"]; 
      } else {
        print("❌ Cloudinary upload failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("⚠️ Cloudinary upload error: $e");
      return null;
    }
  }

  void removeImage(int index) {
    images.removeAt(index);
    imagesUrl.removeAt(index);
    notifyListeners();
  }

  void clearAll() {
    salePrise.clear();
    regularPrise.clear();
    qtyCtrl.clear();
    selectedOptions.clear();
    images.clear();
    imagesUrl.clear();
    notifyListeners();
  }
}
