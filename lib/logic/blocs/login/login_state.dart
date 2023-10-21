part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final Success successModel;
  final bool rememberMe;

  LoginLoaded({required this.successModel, required this.rememberMe});

  @override
  List<Object> get props => [successModel, rememberMe];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'successModel': successModel.toMap(),
      'rememberMe': rememberMe,
    };
  }

  factory LoginLoaded.fromMap(Map<String, dynamic> map) {
    return LoginLoaded(
      successModel: Success.fromMap(map['successModel']),
      rememberMe: map['rememberMe'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginLoaded.fromJson(String source) =>
      LoginLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LoginError extends LoginState {
  final String? message;

  LoginError({required this.message});

  @override
  List<Object> get props => [message!];
}
