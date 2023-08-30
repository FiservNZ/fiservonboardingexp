// import 'package:cloud_firestore/cloud_firestore.dart';

// class Quiz {
//   String id;
//   String title;
//   String description;
//   int quizDuration;
//   int questionCount;
//   late List<Questions> questions;

//   Quiz({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.quizDuration,
//     required this.questionCount,
//     required this.questions,
//   });

//   Quiz.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
//       : id = json.id,
//         title = json['title'],
//         description = json['description'],
//         quizDuration = json['quiz_duration'],
//         questionCount = json['question_count'] as int,
//         questions = [];
// }

// class Questions {
//   final String id;
//   final String question;
//   List<Answers> answers;
//   final String correctAnswer;

//   Questions(
//       {required this.id,
//       required this.question,
//       required this.answers,
//       required this.correctAnswer});
// }

// class Answers {
//   final String identifier;
//   final String answer;

//   Answers({
//     required this.identifier,
//     required this.answer,
//   });
// }
