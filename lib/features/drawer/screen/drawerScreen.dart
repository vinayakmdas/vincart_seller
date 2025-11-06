import 'package:ecommerce_seller/features/addProduct/screens/addProduct_screen.dart';
import 'package:ecommerce_seller/features/dashboard/screen/dashboard.dart';
import 'package:ecommerce_seller/features/drawer/model/drawe_Mode.dart';
import 'package:ecommerce_seller/features/drawer/provider/drawer_provider.dart';
import 'package:ecommerce_seller/features/order_mangement/Screen/order_screen.dart';
import 'package:ecommerce_seller/features/product_management/screen/product_menagement.dart';
import 'package:ecommerce_seller/features/return&refund/screens/refunf&retun_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Drawerscreen extends StatelessWidget {
  const Drawerscreen({super.key});

  // Choose screen based on index
  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return DashboardScreen();
      case 1:
        return Addproduct();
      case 2:
        return ProductMenagement();
      case 3:
        return OrderScreen();
      case 4:
        return RefunfRetunScreen();
      default:
        return Center(
          child: Text(
            "Unknown Screen",
            style: GoogleFonts.cormorantGaramond(
              color: Colors.grey.shade300,
              fontSize: 18,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sideMenu = context.watch<DrawerProvider>();

    final menuItems = [
      SideMenuItems(title: "Dashboard", icon: Icons.dashboard, pageTitle: "Dashboard Overview"),
      SideMenuItems(title: "Add Product", icon: Icons.supervised_user_circle_outlined, pageTitle: "Add Product"),
      SideMenuItems(title: "Product Management", icon: Icons.add_business_sharp, pageTitle: "Product Management"),
      SideMenuItems(title: "Order Details", icon: Icons.headset_mic_outlined, pageTitle: "Order Details"),
      SideMenuItems(title: "Refund and Return Details", icon: Icons.shopping_cart, pageTitle: "Refund and Return Details"),
    ];

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white, // fix black background
      appBar: AppBar(
        title: Text(
          menuItems[sideMenu.selectedIndex].pageTitle,
          style: GoogleFonts.cormorantGaramond(
            
            fontWeight: FontWeight.w600,
          ),

          
        ),
      actions: [
        IconButton(onPressed: (){
          
        }, icon: Icon(Icons.arrow_drop_down_circle_rounded)),
     
      ],
        foregroundColor: Colors.white,
        backgroundColor:Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient:  LinearGradient(colors:  [ Color(0xFF6B21A8), Color(0xFFEC4899), Color(0xFF6B21A8)])
          ),
        ),
        iconTheme: const IconThemeData(color:  Colors.white), // menu icon color
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),

  drawer: Drawer(
  backgroundColor: Colors.white, // dark background for contrast
  child: ListView.separated(
    padding: const EdgeInsets.symmetric(vertical: 20),
    separatorBuilder: (context, index) => const SizedBox(height: 8),
    itemCount: menuItems.length,
    itemBuilder: (context, index) {
      final item = menuItems[index];
      final isSelected = index == sideMenu.selectedIndex;

      return GestureDetector(
        onTap: () {
          context.read<DrawerProvider>().onMenuButton(index);
          Navigator.pop(context); // close drawer
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: isSelected
                ? const LinearGradient(
                    colors: [
                      Color(0xFF6B21A8), // purple
                      Color(0xFFEC4899), // pink
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: isSelected ? null : Colors.transparent,
          ),
          child: ListTile(
            leading: Icon(
              item.icon,
              color: isSelected ? Colors.white : Color(0xFFEC4899), 
            ),
            title: Text(
              item.title,
              style: GoogleFonts.cormorantGaramond(
                color: isSelected ? Colors.white : Color(0xFFEC4899),
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    },
  ),
),


      // Body Section
      body: _buildScreen(sideMenu.selectedIndex),
    );
  }
}
