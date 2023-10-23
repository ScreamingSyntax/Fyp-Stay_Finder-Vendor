// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class OnBoardingState extends Equatable {
  final bool visitedOnBoarding;

  OnBoardingState({
    required this.visitedOnBoarding,
  });

  @override
  List<Object> get props => [visitedOnBoarding];

  OnBoardingState copyWith({
    bool? visitedOnBoarding,
  }) {
    return OnBoardingState(
      visitedOnBoarding: visitedOnBoarding ?? this.visitedOnBoarding,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'visitedOnBoarding': visitedOnBoarding,
    };
  }

  factory OnBoardingState.fromMap(Map<String, dynamic> map) {
    return OnBoardingState(
      visitedOnBoarding: map['visitedOnBoarding'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnBoardingState.fromJson(String source) =>
      OnBoardingState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
