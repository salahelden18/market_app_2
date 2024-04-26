import 'package:equatable/equatable.dart';

enum AuthenticationStates {
  initial,
  loading,
  authenticated,
  notAuthenticated,
}

class AutoAuthenticationState extends Equatable {
  final AuthenticationStates authenticationState;

  const AutoAuthenticationState(this.authenticationState);

  AutoAuthenticationState copyWith({
    AuthenticationStates? authenticationState,
  }) {
    return AutoAuthenticationState(
      authenticationState ?? this.authenticationState,
    );
  }

  @override
  List<Object?> get props => [authenticationState];
}
