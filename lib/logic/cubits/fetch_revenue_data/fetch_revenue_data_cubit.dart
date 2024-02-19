import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

part 'fetch_revenue_data_state.dart';

class FetchRevenueDataCubit extends Cubit<FetchRevenueDataState> {
  RevenueRepository repository = new RevenueRepository();
  FetchRevenueDataCubit() : super(FetchRevenueDataInitial());
  void getRevenue({required String token, String? period}) async {
    emit(FetchRevenueDataLoading());
    Success success =
        await repository.fetchRevenueData(token: token, period: period);
    if (success.success == 0) {
      return emit(FetchRevenueDataError(message: success.message!));
    }
    emit(FetchRevenueDataSuccess(success: success));
  }
}
