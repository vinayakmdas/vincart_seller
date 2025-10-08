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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      SideMenuItems(title: "Add Product", icon: Icons.supervised_user_circle_outlined, pageTitle: "User Management"),
      SideMenuItems(title: "Product Management", icon: Icons.add_business_sharp, pageTitle: "Seller Management"),
      SideMenuItems(title: "Order Details", icon: Icons.headset_mic_outlined, pageTitle: "Customer Service"),
      SideMenuItems(title: "Refund and Return Details", icon: Icons.shopping_cart, pageTitle: "Order Details"),
    ];

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white, // fix black background
      appBar: AppBar(
        title: Text(
          menuItems[sideMenu.selectedIndex].pageTitle,
          style: GoogleFonts.cormorantGaramond(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFFEC4899)), // menu icon color
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),

      // Drawer Section
      drawer: Drawer(
        backgroundColor: const Color(0xFF1A1A1A), // dark background for contrast
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 20),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return ListTile(
              leading: Icon(item.icon, color: Colors.white),
              title: Text(
                item.title,
                style: GoogleFonts.cormorantGaramond(
                  color: Colors.grey.shade300,
                  fontSize: 18,
                ),
              ),
              selected: index == sideMenu.selectedIndex,
              selectedTileColor: const Color(0xFFEC4899).withOpacity(0.2),
              onTap: () {
                context.read<DrawerProvider>().onMenuButton(index);
                Navigator.pop(context); // close drawer
              },
            );
          },
        ),
      ),

      // Body Section
      body: _buildScreen(sideMenu.selectedIndex),
    );
  }
}
