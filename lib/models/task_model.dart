class Task {
  final String id;
  final String description;
  final DateTime created_at;
  final DateTime updated_at;
  final bool done;

  Task({this.id, this.description, this.created_at, this.updated_at, this.done});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      description: json['description'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      done: json['done'],
    );
  }
}