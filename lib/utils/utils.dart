import 'package:flutter/material.dart';

showSnackBar(String content, BuildContext context) {
  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text(content),
  //   ),
  // );
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: const Color(0xFF44484B),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

Id2Name(data) {
  return data.map((e) {
    switch (e) {
      case 'A':
        return '공항철도';
      case 'B':
        return '수인분당선';
      case 'E':
        return '용인경전철';
      case 'G':
        return '경춘선';
      case 'I':
        return '인천1호선';
      case 'I2':
        return '인천2호선';
      case 'K':
        return '경의·중앙선';
      case 'KK':
        return '경강선';
      case 'KP':
        return '김포골드라인';
      case 'S':
        return '신분당선';
      case 'SH':
        return '서해선';
      case 'SL':
        return '신림선';
      case 'U':
        return '의정부경전철';
      case 'W':
        return '우이신설경전철';
      case '1':
        return '1호선';
      case '2':
        return '2호선';
      case '3':
        return '3호선';
      case '4':
        return '4호선';
      case '5':
        return '5호선';
      case '6':
        return '6호선';
      case '7':
        return '7호선';
      case '8':
        return '8호선';
      case '9':
        return '9호선';
      default:
        return e.toString();
    }
  });
}

String truncateString(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return input;
  } else {
    return input.substring(0, maxLength) + "..";
  }
}
