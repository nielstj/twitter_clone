import 'package:equatable/equatable.dart';
import 'package:feeds_repository/feeds_repository.dart';

abstract class FeedsState extends Equatable {
  const FeedsState();

  @override
  List<Object> get props => [];
}

class FeedsLoading extends FeedsState {}

class FeedsLoaded extends FeedsState {
  final List<Feed> feeds;

  const FeedsLoaded([this.feeds = const []]);

  @override
  List<Object> get props => [feeds];

  @override
  String toString() => 'FeedsLoaded { feeds: $feeds }';
}

class FeedsNotLoaded extends FeedsState {}
