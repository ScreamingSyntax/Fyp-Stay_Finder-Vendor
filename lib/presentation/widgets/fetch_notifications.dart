import '../../logic/blocs/bloc_exports.dart';
import '../../logic/cubits/cubit_exports.dart';
import 'widgets_exports.dart';

void callNotificationsMethod(BuildContext context) {
  var state = context.read<LoginBloc>().state;
  if (state is LoginLoaded) {
    context
        .read<FetchNotificationsCubit>()
        .fetchNotification(token: state.successModel.token!);
  }
}
