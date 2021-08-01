import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:feeds_repository/feeds_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:twitter_clone/app/app.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = FirebaseAuthenticationRepository();
  await authenticationRepository.user.first;
  final feedsRepository = FirebaseFeedsRepository();
  runApp(App(
    authenticationRepository: authenticationRepository,
    feedsRepository: feedsRepository,
  ));
}
