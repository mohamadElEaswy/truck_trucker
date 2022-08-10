abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final Object error;
  AuthFailure({required this.error});
}


class AuthSignOut extends AuthState {}
