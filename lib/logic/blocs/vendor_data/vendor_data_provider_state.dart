import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../data/model/vendor.dart';

sealed class VendorDataProviderState extends Equatable {
  const VendorDataProviderState();

  @override
  List<Object> get props => [];
}

final class VendorDataProviderInitial extends VendorDataProviderState {}

final class VendorDataLoading extends VendorDataProviderState {}

final class VendorLoaded extends VendorDataProviderState {
  final Vendor vendorModel;

  VendorLoaded({required this.vendorModel});

  @override
  List<Object> get props => [vendorModel];
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vendorModel': vendorModel.toMap(),
    };
  }

  factory VendorLoaded.fromMap(Map<String, dynamic> map) {
    return VendorLoaded(vendorModel: Vendor.fromMap(map['vendorModel']));
  }
  String toJson() => json.encode(toMap());
  factory VendorLoaded.fromJson(String source) =>
      VendorLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

final class VendorLoadingError extends VendorDataProviderState {
  final String? message;
  VendorLoadingError({required this.message});
}
