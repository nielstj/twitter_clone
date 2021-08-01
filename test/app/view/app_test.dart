import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:feeds_repository/feeds_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:twitter_clone/app/app.dart';
import 'package:twitter_clone/home/bloc/feeds/feeds.dart';
import 'package:twitter_clone/home/home.dart';
import 'package:twitter_clone/login/login.dart';

class MockUser extends Mock implements User {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockFeedsRepository extends Mock implements FeedsRepository {}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

class FakeAppEvent extends Fake implements AppEvent {}

class FakeAppState extends Fake implements AppState {}

class MockFeedsBloc extends MockBloc<FeedsEvent, FeedsState>
    implements FeedsBloc {}

class FakeFeedsEvent extends Fake implements FeedsEvent {}

class FakeFeedsState extends Fake implements FeedsState {}

void main() {
  group('App', () {
    late AuthenticationRepository authenticationRepository;
    late FeedsRepository feedsRepository;
    late User user;

    setUpAll(() {
      registerFallbackValue<AppEvent>(FakeAppEvent());
      registerFallbackValue<AppState>(FakeAppState());
      registerFallbackValue<FeedsEvent>(FakeFeedsEvent());
      registerFallbackValue<FeedsState>(FakeFeedsState());
    });

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      feedsRepository = MockFeedsRepository();
      user = MockUser();
      when(() => authenticationRepository.user).thenAnswer(
        (_) => const Stream.empty(),
      );
      when(() => authenticationRepository.currentUser).thenReturn(user);
      when(() => user.isNotEmpty).thenReturn(true);
      when(() => user.isEmpty).thenReturn(false);
      when(() => user.email).thenReturn('test@gmail.com');
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(
          authenticationRepository: authenticationRepository,
          feedsRepository: feedsRepository,
        ),
      );
      await tester.pump();
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late AuthenticationRepository authenticationRepository;
    late FeedsRepository feedsRepository;

    late AppBloc appBloc;
    late FeedsBloc feedsBloc;

    setUpAll(() {
      registerFallbackValue<AppEvent>(FakeAppEvent());
      registerFallbackValue<AppState>(FakeAppState());
      registerFallbackValue<FeedsEvent>(FakeFeedsEvent());
      registerFallbackValue<FeedsState>(FakeFeedsState());
    });

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      feedsRepository = MockFeedsRepository();
      appBloc = MockAppBloc();
      feedsBloc = MockFeedsBloc();
    });

    testWidgets('navigates to LoginPage when unauthenticated', (tester) async {
      when(() => appBloc.state).thenReturn(const AppState.unauthenticated());
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: authenticationRepository),
            RepositoryProvider.value(value: feedsRepository),
          ],
          child: MaterialApp(
            home: MultiBlocProvider(providers: [
              BlocProvider.value(value: appBloc),
              BlocProvider.value(value: feedsBloc),
            ], child: const AppView()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('navigates to HomePage when authenticated', (tester) async {
      final user = MockUser();
      when(() => user.email).thenReturn('test@gmail.com');
      when(() => appBloc.state).thenReturn(AppState.authenticated(user));
      when(() => feedsBloc.state).thenReturn(FeedsLoaded([]));
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: authenticationRepository),
            RepositoryProvider.value(value: feedsRepository),
          ],
          child: MaterialApp(
            home: MultiBlocProvider(providers: [
              BlocProvider.value(value: appBloc),
              BlocProvider.value(value: feedsBloc..add(LoadFeeds())),
            ], child: const AppView()),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
