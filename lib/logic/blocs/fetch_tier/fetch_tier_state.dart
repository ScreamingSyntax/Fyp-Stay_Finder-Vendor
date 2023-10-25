part of 'fetch_tier_bloc.dart';

sealed class FetchTierState extends Equatable {
  const FetchTierState();

  @override
  List<Object> get props => [];
}

final class FetchTierInitialState extends FetchTierState {}

final class FetchTierLoadingState extends FetchTierState {}

class FetchTierLoaedState extends FetchTierState {
  final List<Tier> tierList;

  FetchTierLoaedState({required this.tierList});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tierList': tierList.map((tier) => tier.toMap()).toList(),
    };
  }

  factory FetchTierLoaedState.fromMap(Map<String, dynamic> map) {
    return FetchTierLoaedState(
      tierList: List<Tier>.from(
        map['tierList'].map((tierMap) => Tier.fromMap(tierMap)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchTierLoaedState.fromJson(String source) {
    return FetchTierLoaedState.fromMap(
        json.decode(source) as Map<String, dynamic>);
  }

  @override
  int get hashCode => tierList.hashCode;
}

final class TierErrorState extends FetchTierState {
  final String errorMessage;
  TierErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
