import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeds_repository/feeds_repository.dart';

class FirebaseFeedsRepository implements FeedsRepository {
  final feedCollection = FirebaseFirestore.instance.collection('feeds');

  @override
  Future<void> addNewFeed(Feed feed) =>
      feedCollection.add(feed.toEntity().toDocument());

  @override
  Future<void> deleteFeed(Feed feed) => feedCollection.doc(feed.id).delete();

  @override
  Stream<List<Feed>> feeds() =>
      feedCollection.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => Feed.fromEntity(FeedEntity.fromSnapshot(doc)))
          .toList());

  @override
  Future<void> updateFeed(Feed feed) =>
      feedCollection.doc(feed.id).update(feed.toEntity().toDocument());
}
