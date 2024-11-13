// lib/function.dart
//import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

String formatTimeHuman(dateTimeString) {
  DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm').parse(dateTimeString);
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 60) {
    return '${difference.inMinutes} 分鐘前';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} 小時前';
  } else {
    // 超過一天顯示具體日期時間
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm ');
    return dateFormat.format(dateTime);
  }
}

void dump(dynamic content, [String name = '']) {
  if (content is Map) {
    content.forEach((key, value) {
      developer.log('Key: $key, Value: ${value.toString()}',
          name: name.isNotEmpty ? name : 'Map');
      if (value is Map) {
        dump(value, name);
      }
    });
  } else if (content is List) {
    for (var i = 0; i < content.length; i++) {
      developer.log('Index $i: ${content[i].toString()}',
          name: name.isNotEmpty ? name : 'List');
      if (content[i] is List) {
        dump(content[i], name);
      }
    }
  } else if (content is Future<String?>) {
    dump('content is Future<String>');
    content.then((value) {
      dump(value);
    });
  } else {
    developer.log(content.toString(), name: name);
  }
}
