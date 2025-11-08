import 'dart:io';
import 'package:ecommerce_seller/features/addProduct/provider/variant_custome_provider.dart';
import 'package:ecommerce_seller/features/addProduct/provider/category_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VariationCustome {
  static Widget variationList(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final dialogProvider = Provider.of<VariationCustomeProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Add Variant", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),

        // 🔹 Attributes (color, size, etc.)
        ...categoryProvider.attributes.map((attr) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(attr.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: attr.options.map((option) {
                  final selected = dialogProvider.selectedOptions[attr.id] == option;
                  return ChoiceChip(
                    label: Text(option),
                    selected: selected,
                    onSelected: (value) {
                      dialogProvider.selectOption(attr.id, option);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
            ],
          );
        }),

       Row(
        children: [
           // 🔹 Price fields
        Expanded(
          child: TextField(
            controller: dialogProvider.regularPrise,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Regular Price"),
          ),
        ),
         const SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: dialogProvider.salePrise,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Sale Price"),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: dialogProvider.qtyCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Quantity"),
          ),
        ),
        ],
       ),

        const SizedBox(height: 16),

        // 🔹 Image Picker Section
        const Text("Product Images", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
       Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // 🔹 Show picked images
            ...List.generate(dialogProvider.images.length, (index) {
              final image = dialogProvider.images[index];
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: kIsWeb
                        ? Image.memory(
                            image.bytes!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(image.path!),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => dialogProvider.removeImage(index),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black54,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(Icons.close, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              );
            }),

            // 🔹 “Add Image” button
            GestureDetector(
              onTap: () async {
                await dialogProvider.pickSingleImage();
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100],
                ),
                child: const Icon(Icons.add_a_photo, color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }
}