
import 'package:ecommerce_seller/features/addProduct/custome/variation_custome.dart';
import 'package:ecommerce_seller/features/addProduct/provider/branList_provider.dart';
import 'package:ecommerce_seller/features/addProduct/provider/category_provider.dart';
import 'package:ecommerce_seller/features/addProduct/provider/variant_provider.dart';
import 'package:ecommerce_seller/theme/app_custome_colour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddproduictCustome {
  static String? selectCategory;
  List<String> brandList = [];

  //^add publish button

  static Widget publishButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: AppColour.purplePinkGradient,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Publish Product",
                style: TextStyle(color: AppColour.whitecolor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //^ requried product details

  static Widget requiredProductDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Row(
        // ✅ Main axis = horizontal
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 🟩 First Container (big one)
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColour.whitecolor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Essential Product Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "This section contains the core product details required for listing",
                          style: TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 20),
                        const Divider(color: AppColour.greycolor),
                        const SizedBox(height: 20),
                        const Text(
                          "Product Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "eg .Premium Cotton T-Shirt",
                            labelStyle: const TextStyle(color: Colors.black87),
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 12,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColour.greycolor,
                                width: 1.5,
                              ),
                            ),
                          ),
                          style: const TextStyle(fontSize: 14),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the product name";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // Save product name value
                          },
                        ),

                        SizedBox(height: 20),
                        const Text(
                          "Product Description",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        // ^ Big text box for product description
                        TextFormField(
                          maxLines: 5,
                          minLines: 3,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            hintText: "Enter product description here...",
                            alignLabelWithHint: true,
                            filled: true,
                            fillColor: AppColour.whitecolor,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                            hintStyle: TextStyle(color: AppColour.greycolor),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColour.greycolor,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColour.greycolor,
                                width: 1.5,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the product description";
                            } else if (value.length < 10) {
                              return "Description should be at least 10 characters long";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // Save description to Firestore or model
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                //^pricing and invendory
                SizedBox(height: 23),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColour.whitecolor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pricing and Inventory",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Regular Price",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                "Sale Price",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                "Stock Count",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "0.00",
                                  labelStyle: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 12,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColour.greycolor,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "0.00",
                                  labelStyle: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 12,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColour.greycolor,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "20",
                                  labelStyle: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 12,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColour.greycolor,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              
                //^Variants Section
SizedBox(height: 23),
Consumer<CategoryProvider>(
  builder: (context, categoryProvider, _) {
    if (categoryProvider.attributes.isEmpty) {
      return const SizedBox();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColour.whitecolor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product Variants",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Add multiple variations like size, color, volume, etc.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // ^ Add Variant Button
           VariationCustome.variationList(context),

            const SizedBox(height: 20),

            // ^ List of Added Variants
            Consumer<VariantProvider>(
              builder: (context, variantProvider, _) {
                if (variantProvider.variants.isEmpty) {
                  return const Text("No variants added yet",
                      style: TextStyle(color: Colors.grey));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: variantProvider.variants.length,
                  itemBuilder: (context, index) {
                    final variant = variantProvider.variants[index];
                    final selectedOptions =
                        variant.selectedOptions.values.join(" / ");
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(selectedOptions),
                        subtitle: Text(
                            "₹${variant.price} • Qty: ${variant.quantity}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            variantProvider.removeVariant(index);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  },
),

              ],
            ),
          ),

          const SizedBox(width: 16), // spacing between containers
          // ^🟦 Second smaller container========================================
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: AppColour.whitecolor,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: const EdgeInsets.only(left: 12, top: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Organize",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12),
                      const Text(
                        "Product Brand",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),

                      // ^select brand dropdown
                      Consumer<BrandListProvider>(
                        builder: (context, provider, child) {
                          return
                          //  provider.isloading? const CircularProgressIndicator()  :
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColour.greycolor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hint: Text(
                                "Select Brand",
                                style: TextStyle(color: AppColour.greycolor),
                              ),

                              fillColor: AppColour.whitecolor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColour.greycolor,
                                ),

                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            initialValue: provider.slectedbrand?.isEmpty ?? true
                                ? null
                                : provider.slectedbrand,
                            items: provider.branlist
                                .map(
                                  (brand) => DropdownMenuItem(
                                    value: brand,
                                    child: Text(brand),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              provider.selectingBrand(value!);
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      //  ^  product category text
                      const Text(
                        "Product Category",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      // ^ selectign category dropdown
                      SizedBox(height: 10),

                      Consumer<CategoryProvider>(
                        builder: (context, provider, child) {
                          return DropdownButtonFormField(
                            initialValue: selectCategory,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColour.greycolor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hint: Text("Select Category"),
                            ),
                            items: provider.categoryList.map((category) {
                              return DropdownMenuItem(
                                value: category.id,
                                child: Text(category.name),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              AddproduictCustome.selectCategory = value;
                              final selectedCat = provider.categoryList
                                  .firstWhere((cat) => cat.id == value);
                              await provider.fetchAttributesForCategory(
                                selectedCat,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
