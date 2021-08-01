import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import '../entities/entities.dart';

@immutable
class Feed {
  final String id;
  final String message;
  final DateTime createdAt;

  Feed({
    String? id,
    required this.message,
    DateTime? time,
  })  : this.id = id ?? Uuid().v4(),
        this.createdAt = time ?? DateTime.now();

  Feed copyWith({String? id, String? message, DateTime? time}) => Feed(
        id: id ?? this.id,
        message: message ?? this.message,
        time: time ?? this.createdAt,
      );

  @override
  int get hashCode => id.hashCode ^ message.hashCode ^ createdAt.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Feed &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          message == other.message &&
          createdAt == other.createdAt;

  @override
  String toString() =>
      'Feed { id: $id, message: $message, createdAt: $createdAt }';

  FeedEntity toEntity() => FeedEntity(
        id,
        message,
        createdAt.microsecondsSinceEpoch,
      );

  static Feed fromEntity(FeedEntity entity) => Feed(
        id: entity.id,
        message: entity.message,
        time: DateTime.fromMicrosecondsSinceEpoch(entity.createdAt),
      );
}
