import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatGptService {
  final String apiKey = dotenv.get('OPENAI_API_KEY', fallback: '');

  Future<String> getResponse(String prompt) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'model': 'text', // Hoặc một mô hình GPT khác mà bạn muốn sử dụng
        'prompt': prompt,
        'max_tokens': 150,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['choices'][0]['text'];
    } else {
      throw Exception('Failed to load response');
    }
  }
}
