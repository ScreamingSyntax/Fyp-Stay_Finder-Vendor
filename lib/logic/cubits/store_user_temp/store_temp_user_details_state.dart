part of 'store_temp_user_details_cubit.dart';

class StoreTempUserDetailsState extends Equatable {
  final File? image;
  final String? name;
  final String? email;
  final String? password;
  StoreTempUserDetailsState({this.image, this.name, this.email, this.password});

  @override
  List<Object> get props {
    if (image == null) {
      return [];
    }
    return [image!, name!, email!, password!];
  }
}
