part of 'storedevicetoken_cubit.dart';

class StoredevicetokenState extends Equatable {
  String? token;
  StoredevicetokenState({this.token});

  @override
  List<Object> get props {
    if (this.token != null) {
      return [this.token!];
    }
    return [];
  }
}
