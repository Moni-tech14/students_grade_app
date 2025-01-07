
class Grade {
  final String subject;
  final String grade;

  Grade({required this.subject, required this.grade});

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      subject: json['subject'],
      grade: json['grade'],
    );
  }
}
