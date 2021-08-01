import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:feeds_repository/feeds_repository.dart';
import 'package:twitter_clone/home/bloc/feeds/feeds.dart';

class FeedsBloc extends Bloc<FeedsEvent, FeedsState> {
  final FeedsRepository _feedsRepository;
  StreamSubscription? _feedsSubscription;

  FeedsBloc({required FeedsRepository feedsRepository})
      : _feedsRepository = feedsRepository,
        super(FeedsLoading());

  @override
  Stream<FeedsState> mapEventToState(FeedsEvent event) async* {
    if (event is LoadFeeds) {
      yield* _mapLoadFeedsToState();
    } else if (event is AddFeed) {
      yield* _mapAddFeedToState(event);
    } else if (event is UpdateFeed) {
      yield* _mapUpdateFeedToState(event);
    } else if (event is DeleteFeed) {
      yield* _mapDeleteFeedToState(event);
    } else if (event is FeedsUpdated) {
      yield* _mapFeedsUpdatedToState(event);
    }
  }

  Stream<FeedsState> _mapLoadFeedsToState() async* {
    _feedsSubscription?.cancel();
    _feedsSubscription =
        _feedsRepository.feeds().listen((feeds) => add(FeedsUpdated(feeds)));
  }

  Stream<FeedsState> _mapAddFeedToState(AddFeed event) async* {
    _feedsRepository.addNewFeed(event.feed);
  }

  Stream<FeedsState> _mapUpdateFeedToState(UpdateFeed event) async* {
    _feedsRepository.updateFeed(event.updatedFeed);
  }

  Stream<FeedsState> _mapDeleteFeedToState(DeleteFeed event) async* {
    _feedsRepository.deleteFeed(event.feed);
  }

  Stream<FeedsState> _mapFeedsUpdatedToState(FeedsUpdated event) async* {
    yield FeedsLoaded(
        event.feeds..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
  }

  @override
  Future<void> close() {
    _feedsSubscription?.cancel();
    return super.close();
  }
}
