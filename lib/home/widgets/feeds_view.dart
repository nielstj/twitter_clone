import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/home/bloc/feeds/feeds.dart';
import 'package:twitter_clone/home/home.dart';
import 'package:twitter_clone/home/view/add_edit_page.dart';

class FeedsView extends StatelessWidget {
  FeedsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedsBloc, FeedsState>(
      builder: (context, state) {
        if (state is FeedsLoading) {
          return LoadingIndicator();
        } else if (state is FeedsLoaded) {
          final feeds = state.feeds;
          return ListView.builder(
              itemCount: feeds.length,
              itemBuilder: (context, index) {
                final feed = feeds[index];
                return FeedItem(
                    onEdit: (f) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditPage(
                              feed: f,
                              onSave: (message) {
                                context.read<FeedsBloc>().add(
                                    UpdateFeed(f.copyWith(message: message)));
                              },
                              isEditing: true,
                            ),
                          ),
                        ),
                    onDelete: (f) =>
                        context.read<FeedsBloc>().add(DeleteFeed(feed)),
                    feed: feed);
              });
        } else {
          return Container();
        }
      },
    );
  }
}
