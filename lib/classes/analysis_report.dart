class AnalysisReport {
  final DateTime createdAt;
  final List<int> totalShopsBranchesList;
  final int? totalShopsBranches;
  final List<int> totalShopsMainList;
  final int? totalShopsMain;
  final List<int> totalActiveList;
  final int? totalActive;
  final List<int> totalSemiActiveList;
  final int? totalSemiActive;
  final int? totalInactive;
  final int? totalSales;
  final int? totalInvoices;
  final int? totalProducts;
  final int? totalExpenses;
  final int? totalCustomers;
  final int? totalPurchases;
  final int? totalOrders;
  final int? totalServiceRecords;
  final int? totalServices;
  final int? totalCategories;
  final int? totalProductionItems;
  final int? totalProductionMaterials;
  final int? totalProductionMaterialsUsage;
  final int? totalProductionRecords;
  final int? totalSubscriptions;
  final int? totalFreePlan;
  final int? totalBasicPlan;
  final int? totalStandardPlan;
  final int? totalPremiumPlan;
  final int? totalSilverPlan;
  final int? totalGoldPlan;
  final int? totalSuppliers;
  final int? totalWaybills;
  final String uuid;

  // Subscription status metrics
  final int? totalSubscribedShops;
  final int? totalTrialSubscribers;
  final int? totalFreePlanSubscribers;
  final int? totalBasicPlanSubscribers;
  final int? totalStandardPlanSubscribers;
  final int? totalPremiumPlanSubscribers;
  final int? totalSilverPlanSubscribers;
  final int? totalGoldPlanSubscribers;
  final int? totalExpiredStores;

  const AnalysisReport({
    required this.createdAt,
    required this.totalShopsBranchesList,
    this.totalShopsBranches,
    required this.totalShopsMainList,
    this.totalShopsMain,
    required this.totalActiveList,
    this.totalActive,
    required this.totalSemiActiveList,
    this.totalSemiActive,
    this.totalInactive,
    this.totalSales,
    this.totalInvoices,
    this.totalProducts,
    this.totalExpenses,
    this.totalCustomers,
    this.totalPurchases,
    this.totalOrders,
    this.totalServiceRecords,
    this.totalServices,
    this.totalCategories,
    this.totalProductionItems,
    this.totalProductionMaterials,
    this.totalProductionMaterialsUsage,
    this.totalProductionRecords,
    this.totalSubscriptions,
    this.totalFreePlan,
    this.totalBasicPlan,
    this.totalStandardPlan,
    this.totalPremiumPlan,
    this.totalSilverPlan,
    this.totalGoldPlan,
    this.totalSuppliers,
    this.totalWaybills,
    required this.uuid,

    // Subscription status metrics
    this.totalSubscribedShops,
    this.totalTrialSubscribers,
    this.totalFreePlanSubscribers,
    this.totalBasicPlanSubscribers,
    this.totalStandardPlanSubscribers,
    this.totalPremiumPlanSubscribers,
    this.totalSilverPlanSubscribers,
    this.totalGoldPlanSubscribers,
    this.totalExpiredStores,
  });
  factory AnalysisReport.fromJson(
    Map<String, dynamic> json,
  ) {
    return AnalysisReport(
      createdAt: DateTime.parse(
        json['created_at'].toString(),
      ),
      totalShopsBranchesList: List<int>.from(
        json['total_shops_branches_list'] ?? [],
      ),
      totalShopsBranches:
          json['total_shops_branches'] as int?,
      totalShopsMainList: List<int>.from(
        json['total_shops_main_list'] ?? [],
      ),
      totalShopsMain: json['total_shops_main'] as int?,
      totalActiveList: List<int>.from(
        json['total_active_list'] ?? [],
      ),
      totalActive: json['total_active'] as int?,
      totalSemiActiveList: List<int>.from(
        json['total_semi_active_list'] ?? [],
      ),
      totalSemiActive: json['total_semi_active'] as int?,
      totalInactive: json['total_inactive'] as int?,
      totalSales: json['total_sales'] as int?,
      totalInvoices: json['total_invoices'] as int?,
      totalProducts: json['total_products'] as int?,
      totalExpenses: json['total_expenses'] as int?,
      totalCustomers: json['total_customers'] as int?,
      totalPurchases: json['total_purchases'] as int?,
      totalOrders: json['total_orders'] as int?,
      totalServiceRecords:
          json['total_service_records'] as int?,
      totalServices: json['total_services'] as int?,
      totalCategories: json['total_categories'] as int?,
      totalProductionItems:
          json['total_production_items'] as int?,
      totalProductionMaterials:
          json['total_production_materials'] as int?,
      totalProductionMaterialsUsage:
          json['total_production_materials_usage'] as int?,
      totalProductionRecords:
          json['total_production_records'] as int?,
      totalSubscriptions:
          json['total_subscriptions'] as int?,
      totalFreePlan: json['total_free_plan'] as int?,
      totalBasicPlan: json['total_basic_plan'] as int?,
      totalStandardPlan:
          json['total_standard_plan'] as int?,
      totalPremiumPlan: json['total_premium_plan'] as int?,
      totalSilverPlan: json['total_silver_plan'] as int?,
      totalGoldPlan: json['total_gold_plan'] as int?,
      totalSuppliers: json['total_suppliers'] as int?,
      totalWaybills: json['total_waybills'] as int?,
      uuid: json['uuid'].toString(),

      totalSubscribedShops:
          (json['total_subscribed_shops'] as num?)?.toInt(),
      totalTrialSubscribers:
          (json['total_trial_subscribers'] as num?)
              ?.toInt(),
      totalFreePlanSubscribers:
          (json['total_free_plan_subscribers'] as num?)
              ?.toInt(),
      totalBasicPlanSubscribers:
          (json['total_basic_plan_subscribers'] as num?)
              ?.toInt(),
      totalStandardPlanSubscribers:
          (json['total_standard_plan_subscribers'] as num?)
              ?.toInt(),
      totalPremiumPlanSubscribers:
          (json['total_premium_plan_subscribers'] as num?)
              ?.toInt(),
      totalSilverPlanSubscribers:
          (json['total_silver_plan_subscribers'] as num?)
              ?.toInt(),
      totalGoldPlanSubscribers:
          (json['total_gold_plan_subscribers'] as num?)
              ?.toInt(),
      totalExpiredStores:
          (json['total_expired_stores'] as num?)?.toInt(),
    );
  }

  double getTotalShops() {
    return ((totalShopsBranches ?? 0) +
            (totalShopsMain ?? 0))
        .toDouble();
  }
}
