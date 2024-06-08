// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:sstation/core/enums/notification.dart';

class Notification extends Equatable {
  final int id;
  final String createdAt;
  final String title;
  final String content;
  bool isRead;
  final NotificationType type;
  final NotificationLevel level;
  Notification({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.content,
    required this.isRead,
    required this.type,
    required this.level,
  });

  Notification copyWith({
    int? id,
    String? createdAt,
    String? title,
    String? content,
    bool? isRead,
    NotificationType? type,
    NotificationLevel? level,
  }) {
    return Notification(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
      level: level ?? this.level,
    );
  }

  @override
  List<Object?> get props => [id];
}
