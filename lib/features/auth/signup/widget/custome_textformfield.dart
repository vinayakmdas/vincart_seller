import 'package:ecommerce_seller/features/auth/login/provider/obsecure_provider.dart';
import 'package:ecommerce_seller/features/auth/signup/provider/dropdown_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText; 
  final String? labelText; 
  final bool isObscure;
  final TextEditingController controller;
  final String? Function(String?) ?validator;
  final IconData? prefixIcon;
 final List<TextInputFormatter>? inputFormatters;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.labelText,
    this.isObscure=false ,
    required this.controller,
     this.validator,
    this.prefixIcon,
    this.inputFormatters
  });

  @override
  Widget build(BuildContext context) {


    return Consumer<ObscureControlling>(

      builder: (context, obscureProvider, child) {

return TextFormField(
        inputFormatters: inputFormatters,
        controller: controller,  
        obscureText: isObscure ?obscureProvider.obscure :false ,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.blueGrey)
              : null,
          suffixIcon: isObscure
              ? IconButton(
                  icon: Icon(
                     isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.blueGrey, 
                  ),
                  onPressed: () {
                    obscureProvider.changing();
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blueGrey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
        ),
      );
      },
      
    );
  }
}


class CustomDropdownField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  final List<String> businessRoles = [
    'Manufacturer',
    'Retailer',
    'Wholesaler',
    'Distributor',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DropdownProvider>(
      builder: (context, dropdownProvider, child) {
        return DropdownButtonFormField<String>(
          value: dropdownProvider.selectedRole,
          hint: Text(widget.hintText),
          items: businessRoles.map((role) {
            return DropdownMenuItem(
              value: role,
              child: Text(role),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              dropdownProvider.setRole(value);
              widget.controller.text = value;
            }
          },
          validator: widget.validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}
