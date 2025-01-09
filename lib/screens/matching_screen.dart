import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:livora/data/models/exam_model.dart';
import 'package:livora/data/models/question_model.dart';

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({super.key});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sınav Adı"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadStates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Hata: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data!;
            var exam = Exam.fromJson(data['exam']);
            var questions = (data['questions'] as List<dynamic>)
                .map((json) => MatchingQuestion.fromJson(json))
                .toList();

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text("Sınav: ${exam.examName}"),
                Text("Kullanıcı: ${exam.examxuserexam.first.userexamxuser.username}"),
                const SizedBox(height: 20),
                for (var question in questions) ...[
                  Text("Soru: ${question.question.questionText}"),
                  for (var pair in question.matchingPairs) ...[
                    Text("Sol: ${pair.itemLeft}"),
                    Text("Sağ: ${pair.itemRight}"),
                  ],
                  const SizedBox(height: 20),
                ],
              ],
            );
          } else {
            return const Center(child: Text("Veri bulunamadı."));
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> loadStates() async {
    try {
      var examJson = await fetchExam(2);
      var questionsJson = await fetchQuestions(2);

      return {
        'exam': examJson,
        'questions': questionsJson,
      };
    } catch (e) {
      throw Exception("Veriler yüklenirken bir hata oluştu: $e");
    }
  }
}

Future<Map<String, dynamic>> fetchExam(int examId) async {
  final String apiUrl = "http://10.0.2.2:4000/api/exams/$examId";
  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Sınav verisi alınamadı.");
    }
  } catch (e) {
    throw Exception("Bağlantı hatası: $e");
  }
}

Future<List<dynamic>> fetchQuestions(int examId) async {
  final String apiUrl = "http://10.0.2.2:4000/api/exams/$examId/questions";
  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception("Sorular alınamadı.");
    }
  } catch (e) {
    throw Exception("Bağlantı hatası: $e");
  }
}
