import 'package:feeds_repository/feeds_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef OnDeleteFeedCallback = Function(Feed feed);
typedef OnEditFeedCallback = Function(Feed feed);

class FeedItem extends StatelessWidget {
  final OnEditFeedCallback onEdit;
  final OnDeleteFeedCallback onDelete;
  final Feed feed;

  FeedItem({
    Key? key,
    required this.onEdit,
    required this.onDelete,
    required this.feed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ListTile(
          title: Text(feed.message),
          subtitle:
              Text(DateFormat.MMMMEEEEd().add_Hms().format(feed.createdAt)),
          leading: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => onEdit(feed),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => onDelete(feed),
          ),
        ),
      ),
    );
  }
}
