import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// This class includes the information needed for the quiz documents
class QuizModel {
  // id stands for the UID for the documents in the Quiz collection
  String id;
  // the fields in a certain document in the Quiz collection
  String title;
  String? imageUrl;
  String description;
  int quizDuration;
  // the collection 'questions' in a quiz document
  List<Question>? questions;
  int questionCount;

  QuizModel(
      {required this.id,
      required this.title,
      this.imageUrl,
      required this.description,
      required this.quizDuration,
      this.questions,
      required this.questionCount});

  // Converts JSON data into a QuizModel object
  QuizModel.fromJSON(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        imageUrl = json['image_url'] as String,
        description = json['description'] as String,
        quizDuration = json['quiz_duration'],
        questionCount = 0,
        questions = (json['questions'] as List)
            .map((dynamic e) => Question.fromJSON(e as Map<String, dynamic>))
            .toList();

  QuizModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title = json['title'],
        imageUrl = json['image_url'],
        description = json['description'],
        quizDuration = json['quiz_duration'],
        questionCount = json['question_count'] as int,
        questions = [];

  // Converts the properties of the QuizModel object into JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> quizModelData = <String, dynamic>{};
    quizModelData['id'] = id;
    quizModelData['title'] = title;
    quizModelData['image_url'] = imageUrl;
    quizModelData['description'] = description;
    quizModelData['quiz_duration'] = quizDuration;

    return quizModelData;
  }
}

// This class refers to the 'questions' collection in a quiz document
class Question {
  String id; // The id for the questions
  // the fields within a questions document
  String question; // the question that will be displayed to the user
  String?
      correctAnswer; // the correct answer within the different options given
  // the collection in the questions document which holds the different options
  List<Option>? options; // that the user can choose their answer from

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  // Converts JSON data into a Question object
  Question.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        options =
            (json['options'] as List).map((e) => Option.fromJSON(e)).toList(),
        correctAnswer = json['correct_answer'];

  Question.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        question = snapshot['question'],
        options = [],
        correctAnswer = snapshot['correct_answer'];

  // Converts the properties of the Question object into JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> questionData = <String, dynamic>{};
    questionData['id'] = id;
    questionData['question'] = question;
    questionData['correct_answer'] = correctAnswer;
    return questionData;
  }
}

// This class holds the information of the options that will be presented to the user to answer a question
class Option {
  // adding a question mark after type string allows it to accept any string
  // or allows the string value to be null. By default Dart does not allow non-nullable variables.
  // https://dart.dev/null-safety
  String?
      identifier; // the identifier is the UID of a document which holds information of an option
  String?
      answer; // this is the option that can be chosen from the user as an answer

  Option({
    this.identifier,
    this.answer,
  });

// Converts JSON data into an Option object
  Option.fromJSON(Map<String, dynamic> json)
      : identifier = json['identifier'],
        answer = json['answer'];

  Option.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'] as String?,
        answer = snapshot['answer'] as String?;

// Converts the properties of the Option object into JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> optionsData = <String, dynamic>{};
    optionsData['identifier'] = identifier;
    optionsData['answer'] = answer;
    return optionsData;
  }
}
