import 'package:flutter/material.dart';

import 'halaman_api.dart';

void main() {
  const endpoint = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://jsonplaceholder.typicode.com/posts',
  );
  runApp(MoneyTrackApiApp(baseUrl: endpoint));
}
