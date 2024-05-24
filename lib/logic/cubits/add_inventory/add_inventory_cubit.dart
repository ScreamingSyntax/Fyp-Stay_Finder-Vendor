import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stayfinder_vendor/data/model/model_exports.dart';
import 'package:stayfinder_vendor/data/repository/repository_exports.dart';

import '../../../data/api/api_exports.dart';

part 'add_inventory_state.dart';

class AddInventoryCubit extends Cubit<AddInventoryState> {
  InventoryRepository inventory = new InventoryRepository();
  AddInventoryCubit() : super(AddInventoryInitial());
  void addInventory(
      {required int inventory,
      required String name,
      required File image,
      required int count,
      required int price,
      required String token}) async {
    emit(AddInventoryLoading());
    Success success = await this.inventory.addInventoryItem(
        token: token,
        inventoryId: inventory,
        name: name,
        count: count.toString(),
        price: price.toString(),
        image: image);
    if (success.success == 0) {
      return emit(AddInventoryError(message: success.message!));
    }
    emit(AddInventorySuccess(message: success.message!));
  }

  void removeInventory({required String token, required int itemId}) async {
    emit(AddInventoryLoading());
    Success success =
        await inventory.deleteInventoryItem(itemId: itemId, token: token);
    if (success.success == 0) {
      return emit(AddInventoryError(message: success.message!));
    }
    emit(AddInventorySuccess(message: success.message!));
  }

  void editInventory(
      {required String token,
      required int itemId,
      required int count,
      required String action}) async {
    emit(AddInventoryLoading());
    Success success = await inventory.editInventoryItem(
        action: action, itemId: itemId, token: token, count: count);
    if (success.success == 0) {
      return emit(AddInventoryError(message: success.message!));
    }
    emit(AddInventorySuccess(message: success.message!));
  }
}
