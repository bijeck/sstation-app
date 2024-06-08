// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:sstation/core/extensions/string_extension.dart';
import 'package:sstation/features/notification/domain/entities/notification.dart';

class NotificationModel extends Notification {
  NotificationModel({
    required super.id,
    required super.createdAt,
    required super.title,
    required super.content,
    required super.isRead,
    required super.type,
    required super.level,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'title': title,
      'content': content,
      'isRead': isRead,
      'type': type.name,
      'level': level.name,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      isRead: map['isRead'] as bool,
      type: (map['type'] as String).toNotificationType(),
      level: (map['level'] as String).toNotificationLevel(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notification(id: $id, createdAt: $createdAt, title: $title, content: $content, isRead: $isRead, type: $type, level: $level)';
  }
}
