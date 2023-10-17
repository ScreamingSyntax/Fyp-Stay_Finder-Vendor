// ignore_for_file: public_member_api_docs, sort_constructors_first
class BlocFormItem {
  final String value;
  final String? error;
  const BlocFormItem({this.value = '', this.error});

  BlocFormItem copyWith({
    String? value,
    String? error,
  }) {
    return BlocFormItem(
      value: value ?? this.value,
      error: error ?? this.error,
    );
  }
}
