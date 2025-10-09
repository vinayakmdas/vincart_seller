
import 'package:ecommerce_seller/features/auth/signup/provider/checkbox_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CostomeCheckBox extends StatelessWidget {
  const CostomeCheckBox({super.key});
  


  @override
  Widget build(BuildContext context) {
    
    return   Consumer<CheckboxProvider>(
      builder:  (context , checkboxprovider ,child){
    return Checkbox(
        
        
        value: checkboxprovider.ischeck, onChanged: (bool? value){
         
         checkboxprovider.changing(value);

        });
      },
    
    );
  }
}