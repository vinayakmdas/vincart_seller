import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CloudinaryService {
  static const String cloudName = 'logocloudname';
  static const String uploadPreset = 'Product_preset';

  static Future<String?> uploadImageToCloudinary(File imageFile) async {
    final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

    final request = http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath("file", imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = jsonDecode(responseData);
      return data["secure_url"]; // ✅ Cloudinary image URL
    } else {
      if (kDebugMode) {
        print("Cloudinary upload failed: ${response.statusCode}");
      }
      return null;
    }
  }
}
