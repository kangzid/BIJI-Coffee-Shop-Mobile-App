import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: AppTextStyles.headingMedium,
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          NotificationItem(
            title: 'Apply Success',
            message: 'You has apply an job in Queenify Group as UI Designer',
            time: '9h ago',
          ),
          Divider(height: 1),
          NotificationItem(
            title: 'Interview Calls',
            message: 'Congratulations! You have interview calls',
            time: '9h ago',
          ),
          Divider(height: 1),
          NotificationItem(
            title: 'Apply Success',
            message: 'You has apply an job in Queenify Group as UI Designer',
            time: '8h ago',
          ),
          Divider(height: 1),
          NotificationItem(
            title: 'Complete your profile',
            message:
                'Please verify your profile information to continue using this app',
            time: '4h ago',
          ),
          Divider(height: 1),
          NotificationItem(
            title: 'Apply Success',
            message: 'You has apply an job in Queenify Group as UI Designer',
            time: '10h ago',
          ),
          Divider(height: 1),
          NotificationItem(
            title: 'Interview Calls',
            message: 'Congratulations! You have interview calls',
            time: '9h ago',
          ),
          Divider(height: 1),
          NotificationItem(
            title: 'Apply Success',
            message: 'You has apply an job in Queenify Group as UI Designer',
            time: '8h ago',
          ),
          Divider(height: 1),
          NotificationItem(
            title: 'Complete your profile',
            message:
                'Please verify your profile information to continue using this app',
            time: '4h ago',
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String time;

  const NotificationItem({
    super.key,
    required this.title,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
