import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FeedEntity extends Equatable {
  final String id;
  final String message;
  final int createdAt;

  const FeedEntity(this.id, this.message, this.createdAt);

  Map<String, Object> toJson() =>
      {"id": id, "message": message, "createdAt": createdAt};

  @override
  List<Object> get props => [id, message, createdAt];

  @override
  String toString() =>
      'FeedEntity { id: $id, message: $message, createdAt: $createdAt}';

  static FeedEntity fromJson(Map<String, Object> json) => FeedEntity(
        json['id'] as String,
        json['message'] as String,
        json['createdAt'] as int,
      );

  static FeedEntity fromSnapshot(DocumentSnapshot snap) => FeedEntity(
        snap.id,
        snap.get('message'),
        snap.get('createdAt'),
      );

  Map<String, Object> toDocument() => {
        'id': id,
        'message': message,
        'createdAt': createdAt,
      };
}
