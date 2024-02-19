import 'package:stayfinder_vendor/presentation/widgets/widgets_exports.dart';

void popMultipleScreens(BuildContext context, int popCount) {
  int count = 0;
  Navigator.popUntil(context, (route) {
    return count++ == popCount || !Navigator.of(context).canPop();
  });
}
