import 'package:authentication_repository/authentication_repository.dart';
import 'package:feeds_repository/feeds_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/app/app.dart';
import 'package:twitter_clone/home/bloc/feeds/feeds.dart';
import 'package:twitter_clone/theme.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required FeedsRepository feedsRepository,
  })  : _authenticationRepository = authenticationRepository,
        _feedsRepository = feedsRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final FeedsRepository _feedsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: _authenticationRepository),
          RepositoryProvider.value(value: _feedsRepository),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(
            create: (_) =>
                AppBloc(authenticationRepository: _authenticationRepository),
          ),
          BlocProvider(
            create: (_) => FeedsBloc(feedsRepository: _feedsRepository),
          )
        ], child: const AppView()));
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (_, current) => current.status == AppStatus.authenticated,
      listener: (context, state) => context.read<FeedsBloc>().add(LoadFeeds()),
      child: MaterialApp(
        theme: theme,
        home: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
        ),
      ),
    );
  }
}
