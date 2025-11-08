import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/category_provider.dart';
import '../provider/variant_provider.dart';
import '../model/variant_model.dart';

class VariantDialog extends StatefulWidget {
  const VariantDialog({super.key});

  @override
  State<VariantDialog> createState() => _VariantDialogState();
}

class _VariantDialogState extends State<VariantDialog> {
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController qtyCtrl = TextEditingController();
  final Map<String, String> selectedOptions = {};
  final List<String> imagesUrl = [];

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return AlertDialog(
      title: const Text("Add Variant"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...categoryProvider.attributes.map((attr) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(attr.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: attr.options.map((option) {
                      final selected = selectedOptions[attr.id] == option;
                      return ChoiceChip(
                        label: Text(option),
                        selected: selected,
                        onSelected: (_) {
                          setState(() => selectedOptions[attr.id] = option);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],
              );
            }),
            TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Price"),
            ),
            TextField(
              controller: qtyCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Quantity"),
            ),
            // TODO: add image picker later
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            if (selectedOptions.isEmpty ||
                priceCtrl.text.isEmpty ||
                qtyCtrl.text.isEmpty) return;

            Provider.of<VariantProvider>(context, listen: false).addVariant(
              VariantModel(
                color: selectedOptions['color'] ?? '',
                size: selectedOptions['size'] ?? '',
                selectedOptions: Map.from(selectedOptions),
                images: imagesUrl,
                price: num.parse(priceCtrl.text),
                quantity: int.parse(qtyCtrl.text),
              ),
            );
            Navigator.pop(context);
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
