// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

List<FaqModel> faqModelFromJson(String str) => List<FaqModel>.from(json.decode(str).map((x) => FaqModel.fromJson(x)));

String faqModelToJson(List<FaqModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaqModel {
  FaqModel({
    this.question,
    this.answer,
  });

  String? question;
  String? answer;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
  };
}
