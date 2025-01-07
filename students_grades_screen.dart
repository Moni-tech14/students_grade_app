
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'grade.dart';
const String baseURL='CSCI410fall2024.atwebpages.com';
class StudentsGradeScreen extends StatefulWidget {
  @override
  _StudentGradesScreenState createState() => _StudentGradesScreenState();
}

class _StudentGradesScreenState extends State<StudentGradesScreen> {
  final _studentIdController = TextEditingController();
  List<Grade> _grades = [];

  Future<void> _fetchGrades() async {
    final response = await http.get(Uri.parse('http://yourdomain/get_student_grades.php?student_id=\${_studentIdController.text}'));
    final data = json.decode(response.body);

    if (data['success']) {
      setState(() {
        _grades = (data['grades'] as List).map((grade) => Grade.fromJson(grade)).toList();
      });
    } else {
      setState(() {
        _grades = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Grades')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _studentIdController,
              decoration: InputDecoration(labelText: 'Enter Student ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchGrades,
              child: Text('Get Grades'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _grades.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Subject: \${_grades[index].subject}'),
                    subtitle: Text('Grade: \${_grades[index].grade}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
