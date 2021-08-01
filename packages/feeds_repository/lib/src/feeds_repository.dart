import 'dart:async';

import 'package:feeds_repository/feeds_repository.dart';

abstract class FeedsRepository {
  Future<void> addNewFeed(Feed feed);

  Future<void> deleteFeed(Feed feed);

  Stream<List<Feed>> feeds();

  Future<void> updateFeed(Feed feed);
}
