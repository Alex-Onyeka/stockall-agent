import 'package:flutter/material.dart';
import 'package:stockallagent/classes/admin_class.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShopInfoProvider extends ChangeNotifier {
  static final ShopInfoProvider _instance =
      ShopInfoProvider._internal();
  factory ShopInfoProvider() => _instance;
  ShopInfoProvider._internal();
  final SupabaseClient _client = Supabase.instance.client;
  final String tableName = 'users_with_shops';

  List<ShopInfo> shopInfos = [];

  Future<List<ShopInfo>> getShops() async {
    if (!isLoading) {
      toggleLoading(true);
      UserClass? user = await returnUserProvider()
          .getUser();
      if (user == null) {
        print('User not Found');
        toggleLoading(false);
        return [];
      } else {
        AdminClass? admin = await returnAdminProvider()
            .getAdmin();
        print("Admin Name: ${admin?.name}");

        if (admin == null) {
          print('📍📍User is Not an Admin');
          try {
            var res = await _client
                .from(tableName)
                .select()
                .eq('agent_uuid', user.userId!);

            if (res.isEmpty) {
              print('No Shops Gotten');
              // shopInfos = [];
              notifyListeners();
              return [];
            }

            shopInfos = res
                .map((shop) => ShopInfo.fromJson(shop))
                .toList();

            print(
              "✅ Shops Gotten Success: ${shopInfos.length}",
            );
            shopInfos.sort(
              (a, b) => a.shopName.toLowerCase().compareTo(
                b.shopName.toLowerCase(),
              ),
            );
            notifyListeners();
            toggleLoading(false);
            return shopInfos;
          } catch (e) {
            print('❌ Error Getting Shops: ${e.toString()}');
            // shopInfos = [];
            notifyListeners();
            toggleLoading(false);
            return [];
          }
        } else {
          print('❤❤User is an Admin');
          try {
            List<Map<String, dynamic>> res = await _client
                .from(tableName)
                .select();

            shopInfos = res
                .map((sh) => ShopInfo.fromJson(sh))
                .toList();
            shopInfos.sort(
              (a, b) => a.shopName.toLowerCase().compareTo(
                b.shopName.toLowerCase(),
              ),
            );

            await returnUserProvider().getAgents();
            await returnReportProvider().getReports();
            print(
              "✅ All Shops Gotten Success: ${shopInfos.length}",
            );
            toggleLoading(false);
            return shopInfos;
          } catch (e) {
            print(
              "❌ Error Getting all Shops: ${e.toString()}",
            );
            // shopInfos = [];
            notifyListeners();
            toggleLoading(false);
            return [];
          }
        }
      }
    } else {
      return [];
    }
  }

  bool isLoading = false;

  void toggleLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<int> setAgent({
    required String agentUuid,
    required bool isDelete,
    required int shopId,
    required String? shopName,
    required String? uuid,
  }) async {
    try {
      toggleLoading(true);
      if (isDelete) {
        var res = await _client
            .from('agents_and_shops')
            .update({
              'agent_uuid': null,
              'assigned_date': null,
            })
            .eq('uuid', uuid ?? agentUuid)
            .select()
            .maybeSingle();

        if (res == null) {
          print('Error Seting Agent');
          return 0;
        }
        print('Agent Set Success');
      } else {
        var res = await _client
            .from('agents_and_shops')
            .upsert({
              'uuid': uuid ?? uuidGen(),
              'agent_uuid': agentUuid,
              'assigned_date': DateTime.now()
                  .toIso8601String(),
              'shop_name': shopName,
              'shop_id': shopId,
            })
            .select()
            .maybeSingle();

        if (res == null) {
          print('Error Seting Agent');
          return 0;
        }

        print('Agent Set Success');
      }
      try {
        var shopRes = await _client
            .from(tableName)
            .select()
            .eq('shop_id', shopId)
            .maybeSingle();
        if (shopRes != null) {
          ShopInfo tempShop = ShopInfo.fromJson(shopRes);
          var shopTwo = shopInfos.firstWhere(
            (item) => item.shopId == tempShop.shopId,
          );
          shopTwo.agentAndShopUuid =
              tempShop.agentAndShopUuid;
          shopTwo.agentComments = tempShop.agentComments;
          shopTwo.agentEmail = tempShop.agentEmail;
          shopTwo.agentFirstName = tempShop.agentFirstName;
          shopTwo.agentLastName = tempShop.agentLastName;
          shopTwo.agentPhone = tempShop.agentPhone;
          shopTwo.agentRoleId = tempShop.agentRoleId;
          shopTwo.agentUuid = tempShop.agentUuid;
          shopTwo.assignedDate = tempShop.assignedDate;
        }
      } catch (e) {
        print(
          'Error Getting Updated Shop: ${e.toString()}',
        );
      }
      notifyListeners();
      toggleLoading(false);
      return 1;
    } catch (e) {
      toggleLoading(false);
      print('Error Setting Agent: ${e.toString()}');
      return 0;
    }
  }

  Future<int> setBusinessBoolValues({
    bool? isDelete,
    bool? isImportant,
    bool? isImportanter,
    bool? isImportantest,
    required String uuidd,
    required int shopId,
  }) async {
    try {
      toggleLoading(true);
      Map<String, dynamic> value() {
        if (isDelete != null) {
          return {'is_deleted': isDelete};
        } else if (isImportant != null) {
          return {'is_important': isImportant};
        } else if (isImportanter != null) {
          return {'is_importanter': isImportanter};
        } else {
          return {'is_importantest': isImportantest};
        }
      }

      var res = await _client
          .from('agents_and_shops')
          .update(value())
          .eq('uuid', uuidd)
          .select()
          .maybeSingle();

      if (res == null) {
        print('Error Seting Agent');
        return 0;
      }
      print('Agent Set Success');
      try {
        var shopRes = await _client
            .from(tableName)
            .select()
            .eq('shop_id', shopId)
            .maybeSingle();
        if (shopRes != null) {
          ShopInfo tempShop = ShopInfo.fromJson(shopRes);
          var shopTwo = shopInfos.firstWhere(
            (item) => item.shopId == tempShop.shopId,
          );
          shopTwo.isDeleted = tempShop.isDeleted;
          shopTwo.isImportant = tempShop.isImportant;
          shopTwo.isImportanter = tempShop.isImportanter;
          shopTwo.isImportantest = tempShop.isImportantest;
        }
      } catch (e) {
        print(
          'Error Getting Updated Shop: ${e.toString()}',
        );
      }
      notifyListeners();
      toggleLoading(false);
      return 1;
    } catch (e) {
      toggleLoading(false);
      print('Error Setting Agent: ${e.toString()}');
      return 0;
    }
  }

  Future<void> updateAgentShopComment({
    required String agentAndShopUuid,
    required String? newComment,
    required String? commentUuid,
    required String agentUuid,
    required String agentName,
    required int shopId,
  }) async {
    try {
      toggleLoading(true);

      // Get current comments
      final response = await _client
          .from('agents_and_shops')
          .select('comments')
          .eq('uuid', agentAndShopUuid)
          .single();

      final List<dynamic> rawComments =
          response['comments'] ?? [];

      final List<Comment> comments = rawComments
          .map(
            (item) => Comment.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();

      if (newComment != null &&
          newComment.trim().isNotEmpty) {
        // ADD COMMENT

        final comment = Comment(
          uuid: uuidGen(),
          agentUuid: agentUuid,
          agentName: agentName,
          createdAt: DateTime.now(),
          comment: newComment.trim(),
        );

        comments.add(comment);
      } else if (commentUuid != null) {
        // REMOVE ONLY THE SELECTED COMMENT

        comments.removeWhere(
          (item) => item.uuid == commentUuid,
        );
      }

      // Convert comments back to JSON
      final updatedComments = comments
          .map((item) => item.toJson())
          .toList();

      // Update database
      await _client
          .from('agents_and_shops')
          .update({'comments': updatedComments})
          .eq('uuid', agentAndShopUuid);

      // Get updated shop information
      try {
        final shopRes = await _client
            .from(tableName)
            .select()
            .eq('shop_id', shopId)
            .maybeSingle();

        if (shopRes != null) {
          final ShopInfo tempShop = ShopInfo.fromJson(
            shopRes,
          );

          final shopTwo = shopInfos.firstWhere(
            (item) => item.shopId == tempShop.shopId,
          );

          shopTwo.agentAndShopUuid =
              tempShop.agentAndShopUuid;

          shopTwo.agentComments = tempShop.agentComments;

          shopTwo.agentEmail = tempShop.agentEmail;

          shopTwo.agentFirstName = tempShop.agentFirstName;

          shopTwo.agentLastName = tempShop.agentLastName;

          shopTwo.agentPhone = tempShop.agentPhone;

          shopTwo.agentRoleId = tempShop.agentRoleId;

          shopTwo.agentUuid = tempShop.agentUuid;
          shopTwo.assignedDate = tempShop.assignedDate;
        }
      } catch (e) {
        print(
          'Error Getting Updated Shop: ${e.toString()}',
        );
      }

      toggleLoading(false);
      notifyListeners();
    } catch (e) {
      toggleLoading(false);

      print('Error Updating Comment: ${e.toString()}');
    }
  }

  List<ShopInfo> getTodaysRegisteredStores() {
    var tempSh = shopInfos
        .where(
          (sh) =>
              sh.shopCreatedAt.isAfter(
                dayStart(DateTime.now()),
              ) ||
              sh.shopCreatedAt.isAtSameMomentAs(
                dayStart(DateTime.now()),
              ),
        )
        .toList();
    tempSh.sort(
      (a, b) => b.shopCreatedAt.compareTo(a.shopCreatedAt),
    );
    return tempSh;
  }

  List<ShopInfo> getAssignedStores() {
    var tempSh = shopInfos
        .where((sh) => sh.agentUuid == currentUser().userId)
        .toList();
    tempSh.sort(
      (a, b) => b.shopCreatedAt.compareTo(a.shopCreatedAt),
    );
    return tempSh;
  }

  List<ShopInfo> getThisMonthRegisteredStores() {
    var tempSh = shopInfos
        .where(
          (sh) =>
              sh.shopCreatedAt.isAfter(monthStart()) ||
              sh.shopCreatedAt.isAtSameMomentAs(
                monthStart(),
              ),
        )
        .toList();
    tempSh.sort(
      (a, b) => b.shopCreatedAt.compareTo(a.shopCreatedAt),
    );
    return tempSh;
  }

  List<ShopInfo> getThisMonthSubscribedShops() {
    return shopInfos
        .where(
          (item) =>
              item.isTrial == false &&
              ((item.subscriptionLastPayment?.isAfter(
                        monthStart(),
                      ) ==
                      true) ||
                  item.subscriptionLastPayment
                          ?.isAtSameMomentAs(
                            monthStart(),
                          ) ==
                      true),
        )
        .toList();
  }

  List<ShopInfo> getTodaysSubscribedShops() {
    return shopInfos
        .where(
          (item) =>
              item.isTrial == false &&
              ((item.subscriptionLastPayment?.isAfter(
                        dayStart(DateTime.now()),
                      ) ==
                      true) &&
                  item.subscriptionLastPayment?.isBefore(
                        dayEnd(DateTime.now()),
                      ) ==
                      true),
        )
        .toList();
  }

  List<ShopInfo> getTodaysSubscribedShopsFree() {
    return getTodaysSubscribedShops()
        .where((item) => item.isFree())
        .toList();
  }

  List<ShopInfo> getTodaysSubscribedShopsBasic() {
    return getTodaysSubscribedShops()
        .where((item) => item.isBasicPlan())
        .toList();
  }

  List<ShopInfo> getTodaysSubscribedShopsStandard() {
    return getTodaysSubscribedShops()
        .where((item) => item.isStandardPlan())
        .toList();
  }

  List<ShopInfo> getTodaysSubscribedShopsPremium() {
    return getTodaysSubscribedShops()
        .where((item) => item.isPremiumPlan())
        .toList();
  }

  List<ShopInfo> getTodaysSubscribedShopsSilver() {
    return getTodaysSubscribedShops()
        .where((item) => item.isSilverPlan())
        .toList();
  }

  List<ShopInfo> getTodaysSubscribedShopsGold() {
    return getTodaysSubscribedShops()
        .where((item) => item.isGoldPlan())
        .toList();
  }

  List<ShopInfo> getTotalActiveShops() {
    return shopInfos
        .where((item) => item.isActive == true)
        .toList();
  }

  List<ShopInfo> getTotalInActiveShops() {
    return shopInfos
        .where((item) => item.isInactive == true)
        .toList();
  }

  List<ShopInfo> getTotalSemiActiveShops() {
    return shopInfos
        .where((item) => item.isSemiActive == true)
        .toList();
  }

  List<ShopInfo> getTotalTrialShops() {
    return shopInfos
        .where((item) => item.isTrial == true)
        .toList();
  }

  List<ShopInfo> getTotalExpiredShops() {
    return shopInfos
        .where((item) => item.isExpired == true)
        .toList();
  }

  List<ShopInfo> getTotalSubscribedShops() {
    return shopInfos
        .where(
          (item) =>
              !item.isTrial &&
              !item.isExpired &&
              item.currentPlan != 0 &&
              item.subscriptionNextPayment != null,
        )
        .toList();
  }

  List<ShopInfo> getTotalSubscribedBasic() {
    return getTotalSubscribedShops()
        .where((item) => item.isBasicPlan())
        .toList();
  }

  List<ShopInfo> getTotalSubscribedStandard() {
    return getTotalSubscribedShops()
        .where((item) => item.isStandardPlan())
        .toList();
  }

  List<ShopInfo> getTotalSubscribedPremium() {
    return getTotalSubscribedShops()
        .where((item) => item.isPremiumPlan())
        .toList();
  }

  List<ShopInfo> getTotalSubscribedSilver() {
    return getTotalSubscribedShops()
        .where((item) => item.isSilverPlan())
        .toList();
  }

  List<ShopInfo> getTotalSubscribedGold() {
    return getTotalSubscribedShops()
        .where((item) => item.isGoldPlan())
        .toList();
  }

  List<ShopInfo> getTotalFreeShops() {
    return shopInfos
        .where(
          (item) =>
              !item.isTrial &&
              !item.isExpired &&
              item.currentPlan == 0,
        )
        .toList();
  }

  double getTotalBranchShops() {
    return shopInfos
        .map((item) => item.shopBranches)
        .fold(0, (a, b) => a + b);
  }

  double getAllShops() {
    return shopInfos.length + getTotalBranchShops();
  }
}
