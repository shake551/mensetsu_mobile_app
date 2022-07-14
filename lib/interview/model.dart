
class InterviewModel {
  final int id;
  final String content, created_at, updated_at;

  InterviewModel(
    this.id,
    this.content,
    this.created_at,
    this.updated_at,
  );

  InterviewModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        created_at = json['created_at'],
        updated_at = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'created_at': created_at,
        'updated_at': updated_at,
      };
}
