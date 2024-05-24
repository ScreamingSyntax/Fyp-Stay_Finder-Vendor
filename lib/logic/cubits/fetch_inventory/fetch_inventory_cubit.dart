import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';
import 'package:stayfinder_vendor/logic/blocs/bloc_exports.dart';

part 'fetch_inventory_state.dart';

class FetchInventoryCubit extends Cubit<FetchInventoryState> {
  InventoryRepository inventory = new InventoryRepository();
  FetchInventoryCubit() : super(FetchInventoryInitial());
  void fetchInventory(
      {required String token,
      required int accommodationId,
      String? type,
      String? date,
      String? startDate,
      String? endDate}) async {
    emit(FetchInventoryLoading());
    Success success = await inventory.fetchInventory(
        token: token,
        accommodationId: accommodationId,
        date: date,
        endDate: endDate,
        startDate: startDate,
        type: type);
    if (success.success == 0) {
      return emit(FetchInventoryError(message: success.message!));
    }
    Map status = success.data!['status'];
    return emit(FetchInventorySuccess(
        items: List.from(success.data!['items'])
            .map((e) => InventoryItemModel.fromMap(e))
            .toList(),
        itemLogs: List.from(success.data!['logs'])
            .map((e) => InventoryLogs.fromMap(e))
            .toList(),
        ins: status['ins'],
        outs: status['outs'],
        total: status['total']));
  }

  @override
  void onChange(Change<FetchInventoryState> change) {
    print("C :${change.currentState} N: ${change.nextState}");
    super.onChange(change);
  }
}
