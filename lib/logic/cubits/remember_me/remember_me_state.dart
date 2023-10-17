// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class RememberMeState extends Equatable {
  final bool rememberMe;
  const RememberMeState({required this.rememberMe});

  @override
  List<Object> get props => [rememberMe];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rememberMe': rememberMe,
    };
  }

  factory RememberMeState.fromMap(Map<String, dynamic> map) {
    return RememberMeState(
      rememberMe: map['rememberMe'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory RememberMeState.fromJson(String source) =>
      RememberMeState.fromMap(json.decode(source) as Map<String, dynamic>);
}
