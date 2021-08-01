import 'package:equatable/equatable.dart';
import 'package:feeds_repository/feeds_repository.dart';

abstract class FeedsEvent extends Equatable {
  const FeedsEvent();

  @override
  List<Object?> get props => [];
}

class LoadFeeds extends FeedsEvent {}

class AddFeed extends FeedsEvent {
  final Feed feed;

  const AddFeed(this.feed);

  @override
  List<Object?> get props => [feed];

  @override
  String toString() => 'AddFeed { feed: $feed }';
}

class UpdateFeed extends FeedsEvent {
  final Feed updatedFeed;

  const UpdateFeed(this.updatedFeed);

  @override
  List<Object?> get props => [updatedFeed];

  @override
  String toString() => 'UpdateFeed { updatedFeed: $updatedFeed }';
}

class DeleteFeed extends FeedsEvent {
  final Feed feed;

  const DeleteFeed(this.feed);

  @override
  List<Object?> get props => [feed];

  @override
  String toString() => 'DeleteFeed { feed: $feed }';
}

class FeedsUpdated extends FeedsEvent {
  final List<Feed> feeds;

  const FeedsUpdated(this.feeds);

  @override
  List<Object?> get props => [feeds];

  @override
  String toString() => 'FeedsUpdated { feeds: $feeds }';
}
