import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav.dart';
import 'widgets/header_section.dart';
import 'widgets/promotion_section.dart';
import 'widgets/category_section.dart';
import '../../core/routes/app_routes.dart'; // <-- Import ini tetap diperlukan untuk Bottom Nav

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    // Navigasi asli dari bottom nav Anda
    switch (index) {
      case 0:
        // Anda sudah di Home, tidak perlu navigasi
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.cart);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.rewards);
        break;
      case 3:
        Navigator.pushNamed(context, AppRoutes.profile);
        break;
    }
    // Set state hanya jika halaman ini tetap terlihat (yaitu, tetap di tab Home)
    if (index == 0) {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onNavTap, // Gunakan fungsi _onNavTap
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding ditambahkan per-seksi
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: HeaderSection(),
              ),
              const SizedBox(height: 20),
              // PromotionSection & CategorySection sudah punya padding sendiri
              const PromotionSection(),
              const SizedBox(height: 25),
              const CategorySection(),
              const SizedBox(height: 20), // Spasi di akhir halaman
            ],
          ),
        ),
      ),
    );
  }
}