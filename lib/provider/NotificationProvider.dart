// notification_provider.dart
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationItem> _notifications = [];

  List<NotificationItem> get notifications => _notifications;

  NotificationProvider() {
    // Initialize with sample data
    _notifications = [
      NotificationItem(
        id: '1',
        type: NotificationType.login,
        title: 'Successful Login',
        message: 'You logged in to your account',
        time: DateTime.now().subtract(Duration(minutes: 5)),
        isRead: false,
      ),
      NotificationItem(
        id: '2',
        type: NotificationType.courseEnrolled,
        title: 'Course Enrolled',
        message: 'You have enrolled in "Advanced Navigation Techniques"',
        time: DateTime.now().subtract(Duration(hours: 2)),
        isRead: false,
      ),
      NotificationItem(
        id: '3',
        type: NotificationType.courseCompleted,
        title: 'Course Completed',
        message: 'Congratulations! You completed "Maritime Safety"',
        time: DateTime.now().subtract(Duration(days: 1)),
        isRead: false,
      ),
      NotificationItem(
        id: '4',
        type: NotificationType.reminder,
        title: 'Continue Learning',
        message: 'Understanding Ships Operating in Polar Waters is up next.',
        time: DateTime.now().subtract(Duration(days: 2)),
        isRead: false,
      ),
      NotificationItem(
        id: '5',
        type: NotificationType.reminder,
        title: 'Upcoming Deadline',
        message: 'Assignment due tomorrow for "Port Operations"',
        time: DateTime.now().subtract(Duration(days: 3)),
        isRead: false,
      ),
    ];
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
    notifyListeners();
  }

  void deleteNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    notifyListeners();
  }
}

enum NotificationType {
  login,
  courseEnrolled,
  courseCompleted,
  continueLearning,
  reminder,
}

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final DateTime time;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });

  IconData get icon {
    switch (type) {
      case NotificationType.login:
        return Icons.login;
      case NotificationType.courseEnrolled:
        return Icons.school;
      case NotificationType.courseCompleted:
        return Icons.verified;
      case NotificationType.continueLearning:
        return Icons.timer;
      case NotificationType.reminder:
        return Icons.notifications;
      default:
        return Icons.notifications;
    }
  }

  Color get color {
    switch (type) {
      case NotificationType.login:
        return Colors.blue;
      case NotificationType.courseEnrolled:
        return Colors.green;
      case NotificationType.courseCompleted:
        return Colors.purple;
      case NotificationType.continueLearning:
        return Colors.orange;
      case NotificationType.reminder:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}