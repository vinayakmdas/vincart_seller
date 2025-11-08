
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

class VariationCustomeProvider extends ChangeNotifier {
  final TextEditingController qtyCtrl = TextEditingController();
  final TextEditingController regularPrise = TextEditingController();

  final TextEditingController salePrise = TextEditingController();
  final Map<String, String> selectedOptions = {};
final List<PlatformFile> images = [];

  
   void selectOption(String attrId, String option) {
    selectedOptions[attrId] = option;
    notifyListeners();
  }
  
  Future<void> pickSingleImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if  (result != null && result.files.isNotEmpty)  {
      images.add(result.files.single);
      notifyListeners();
    }
  }


  void removeImage(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  void clearAll() {
    salePrise.clear();
    regularPrise.clear();
    qtyCtrl.clear();
    selectedOptions.clear();
    images.clear();
    notifyListeners();
  }

}