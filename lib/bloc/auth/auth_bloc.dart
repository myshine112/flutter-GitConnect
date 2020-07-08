import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_github_connect/bloc/auth/index.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // AuthBloc();
  // todo: check singleton for logic in project
  // static final AuthBloc _authBlocSingleton = AuthBloc._internal();
  // factory AuthBloc() {
  //   return _authBlocSingleton;
  // }
  // AuthBloc._internal();

  // @override
  // Future<void> close() async {
  //   // dispose objects
  //   await super.close();
  // }

  @override
  AuthState get initialState => LoadingWebViewState(loadingView: true);
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    try {
      if (event is LoadAuthEvent) {
        yield* event.getAcessToken(currentState: state, bloc: this);
      } else if (event is LoadingWebView) {
        developer.log("Open Web view", name: "AuthBloc");
        yield LoadingWebViewState(loadingView: true);
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'AuthBloc', error: _, stackTrace: stackTrace);
      yield ErrorAuthState(_);
    }
  }
}
