import 'package:stayfinder_vendor/data/api/api_exports.dart';

import '../model/model_exports.dart';

class InventoryRepository {
  InventoryApiProvider inventory = new InventoryApiProvider();
  Future<Success> fetchInventory(
      {required String token,
      required int accommodationId,
      String? type,
      String? date,
      String? startDate,
      String? endDate}) async {
    return await inventory.fetchInventory(
      token: token,
      accommodationId: accommodationId,
      type: type,
      date: date,
      endDate: endDate,
    );
  }

  Future<Success> addInventoryItem(
      {required String token,
      required int inventoryId,
      required String name,
      required String count,
      required String price,
      required File image}) async {
    return await inventory.addInventoryItem(
        token: token,
        inventoryId: inventoryId,
        name: name,
        count: count,
        price: price,
        image: image);
  }

  Future<Success> deleteInventoryItem(
      {required int itemId, required String token}) async {
    return await inventory.deleteInventoryItem(itemId: itemId, token: token);
  }

  Future<Success> editInventoryItem(
      {required int itemId,
      required int count,
      required String token,
      required String action}) async {
    return await inventory.editInventoryItem(
        action: action, itemId: itemId, count: count, token: token);
  }
}
