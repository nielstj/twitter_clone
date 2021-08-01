import 'package:feeds_repository/feeds_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/app/app.dart';
import 'package:twitter_clone/home/bloc/feeds/feeds.dart';
import 'package:twitter_clone/home/home.dart';
import 'package:twitter_clone/home/view/add_edit_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          )
        ],
      ),
      body: FeedsView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditPage(
                onSave: (message) {
                  context
                      .read<FeedsBloc>()
                      .add(AddFeed(Feed(message: message)));
                },
                isEditing: false,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Feed',
      ),
    );
  }
}
