import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_clone/app/app.dart';
import 'package:twitter_clone/home/bloc/feeds/feeds.dart';
import 'package:twitter_clone/home/home.dart';
import 'package:twitter_clone/home/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

class FakeAppEvent extends Fake implements AppEvent {}

class FakeAppState extends Fake implements AppState {}

class MockUser extends Mock implements User {}

class MockFeedsBloc extends MockBloc<FeedsEvent, FeedsState>
    implements FeedsBloc {}

class FakeFeedsEvent extends Fake implements FeedsEvent {}

class FakeFeedsState extends Fake implements FeedsState {}

void main() {
  const logoutButtonKey = Key('homePage_logout_iconButton');
  group('HomePage', () {
    late AppBloc appBloc;
    late FeedsBloc feedsBloc;
    late User user;

    setUpAll(() {
      registerFallbackValue<AppEvent>(FakeAppEvent());
      registerFallbackValue<AppState>(FakeAppState());
      registerFallbackValue<FeedsEvent>(FakeFeedsEvent());
      registerFallbackValue<FeedsState>(FakeFeedsState());
    });

    setUp(() {
      appBloc = MockAppBloc();
      feedsBloc = MockFeedsBloc();
      user = MockUser();
      when(() => user.email).thenReturn('test@gmail.com');
      when(() => appBloc.state).thenReturn(AppState.authenticated(user));
      when(() => feedsBloc.state).thenReturn(FeedsLoaded([]));
    });

    group('calls', () {
      testWidgets('AppLogoutRequested when logout is pressed', (tester) async {
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(value: appBloc),
              BlocProvider.value(value: feedsBloc..add(LoadFeeds())),
            ],
            child: const MaterialApp(home: HomePage()),
          ),
        );
        await tester.tap(find.byKey(logoutButtonKey));
        verify(() => appBloc.add(AppLogoutRequested())).called(1);
      });
    });

    group('renders', () {
      testWidgets('FeedsView widget', (tester) async {
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(value: appBloc),
              BlocProvider.value(value: feedsBloc..add(LoadFeeds())),
            ],
            child: const MaterialApp(home: HomePage()),
          ),
        );
        expect(find.byType(FeedsView), findsOneWidget);
      });
    });
  });
}
