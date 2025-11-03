import 'package:flutter/material.dart';
import '../../pages/onboarding/onboarding_page.dart';
import '../../pages/welcome/welcome_page.dart';
import '../../pages/auth/login_page.dart';
import '../../pages/home/home_page.dart';
import '../../pages/cart/cart_page.dart';
import '../../pages/rewards/rewards_page.dart';
import '../../pages/profile/profile_page.dart';
import '../../pages/products/products_page.dart';

// --- TAMBAHKAN IMPORT INI ---
// Pastikan Anda sudah membuat file-file ini dari langkah saya sebelumnya
import '../../pages/messages/message_list_page.dart';
import '../../pages/messages/chat_detail_page.dart';
import '../../pages/tracker/delivery_tracker_page.dart';
// ----------------------------

class AppRoutes {
  // Daftar route name
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String cart = '/cart';
  static const String rewards = '/rewards';
  static const String profile = '/profile';
  static const String products = '/products';

  // --- TAMBAHKAN ROUTE NAME INI ---
  static const String messageList = '/messages';
  static const String chatDetail = '/chat-detail';
  static const String deliveryTracker = '/tracker';
  // ---------------------------------

  // Generator route
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      // case register:
      //   return MaterialPageRoute(builder: (_) => const RegisterPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case cart:
        return MaterialPageRoute(builder: (_) => const CartPage());
      case rewards:
        return MaterialPageRoute(builder: (_) => const RewardsPage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case products:
        return MaterialPageRoute(builder: (_) => const ProductsPage());

      // --- TAMBAHKAN CASE INI ---
      case messageList:
        return MaterialPageRoute(builder: (_) => const MessageListPage());
      case chatDetail:
        // Mengambil argumen (nama) yang dikirim saat navigasi
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (_) => ChatDetailPage(
                  userName: args?['name'] ?? 'Chat',
                  userAvatar: args?['avatar'] ?? 'assets/images/profile1.jpg',
                  userId: args?['id'] ?? 'ID 2445556',
                ));
      case deliveryTracker:
        return MaterialPageRoute(builder: (_) => const DeliveryTrackerPage());
      // ----------------------------

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'Page not found',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        );
    }
  }
}