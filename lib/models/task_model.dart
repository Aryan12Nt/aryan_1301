class TaskModel {
  final String task;
  final String description;
  bool isCompleted;
  final String docID;
  final String categorie;
  final String dueDate;

  TaskModel({
    required this.docID,
    required this.isCompleted,
    required this.task,
    required this.description,
    required this.categorie,
    required this.dueDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "docId": docID,
      "isCompleted": isCompleted,
      'task': task,
      'description': description,
      'categorie': categorie,
      'dueDate': dueDate,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      docID: json["docId"],
      isCompleted: json["isCompleted"],
      task: json['task'],
      description: json['description'],
      categorie: json['categorie'],
      dueDate: json['dueDate'],
    );
  }
}
