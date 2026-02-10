
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller/features/addProduct/custome/variation_custome.dart';
import 'package:ecommerce_seller/features/addProduct/model/product_model.dart';
import 'package:ecommerce_seller/features/addProduct/provider/branList_provider.dart';
import 'package:ecommerce_seller/features/addProduct/provider/category_provider.dart';
import 'package:ecommerce_seller/features/addProduct/provider/uploading_provider.dart';
import 'package:ecommerce_seller/features/addProduct/provider/variant_provider.dart';
import 'package:ecommerce_seller/theme/app_custome_colour.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddproduictCustome {
  static String? selectCategory;
  List<String> brandList = [];
static TextEditingController productnameController = TextEditingController();
static TextEditingController descriptionControler = TextEditingController();
  //^add publish button

  static Widget publishButton(BuildContext context) {
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
             

                onPressed: () async {
  final variantProvider = Provider.of<VariantProvider>(context, listen: false);
  final uploadProvider = Provider.of<ProductUploadProvider>(context, listen: false);
  final brandlist = Provider.of<BrandListProvider>(context, listen: false);

  if (variantProvider.variants.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please add at least one variant.")),
    );
    return;
  }

  final sellerUid = FirebaseAuth.instance.currentUser;
  if (sellerUid == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please log in first.")),
    );
    return;
  }
  
Future<String> getSellerName(String sellerUid) async {
  try {
    final doc = await FirebaseFirestore.instance
        .collection("sellers")
        .doc(sellerUid)
        .get();

    if (doc.exists) {
      return doc.data()?['sellerName'] ?? "Unknown Seller";
    } else {
      return "Unknown Seller";
    }
  } catch (e) {
    print("Error fetching seller name: $e");
    return "Unknown Seller";
  }
}

 
 final uid = FirebaseAuth.instance.currentUser;
final sellerName = await getSellerName(uid!.uid);
 print("seller name : $sellerName");
final product = ProductModel(
  sellerName:   sellerName.toString(),
  productName: productnameController.text.trim(),
  description: descriptionControler.text.trim(),
  brandId: brandlist.slectedbrand ?? '',
  categoryId: AddproduictCustome.selectCategory ?? '',
  sellerId: sellerUid.uid,
  createdAt: DateTime.now(),
  variants: variantProvider.variants,
  status:  "active"
);

  await uploadProvider.uploadProduct(product);
  variantProvider.clear();

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("✅ Product uploaded successfully!")),
  );
},

            
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
                          controller:productnameController ,
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
                          controller:  descriptionControler,
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
      return const Text("No variants added yet");
    }

    return Column(
      children: variantProvider.variants.map((variant) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            title: Text(
                "Size: ${variant.size}, Color: ${variant.color}, Price: ₹${variant.price}"),
            subtitle: Text("Qty: ${variant.quantity}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                final provider =
                    Provider.of<VariantProvider>(context, listen: false);
                final index = variantProvider.variants.indexOf(variant);
                provider.removeVariant(index);
              },
            ),
          ),
        );
      }).toList(),
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
                              hint: Text(
                                "Select Category",
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
