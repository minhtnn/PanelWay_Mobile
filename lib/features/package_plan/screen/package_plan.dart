import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/data/payloads/requests/create_payos_request.dart';
import 'package:panelway_mobile/data/payloads/responses/payos_check_response.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:panelway_mobile/features/package_plan/view_model/subcription_view_model.dart';
import 'package:panelway_mobile/features/package_plan/widgets/package_information.dart';
import 'package:provider/provider.dart';

class PackagePlan extends StatefulWidget {
  const PackagePlan({super.key});

  @override
  State<PackagePlan> createState() => _PackagePlanState();
}

class _PackagePlanState extends State<PackagePlan> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Safely get the ViewModel
        final subscriptionVM =
            Provider.of<SubcriptionViewModel>(context, listen: false);
        subscriptionVM.getSubcriptions();

        // Safely get the AuthViewModel
        final authVM = Provider.of<AuthViewModel>(context, listen: false);
        authVM.getAccount().then((account) async {
          if (mounted && account != null && account.id != null) {
            subscriptionVM.getCurrentSubcription(account.id ?? "", "Active");
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);
    // Safely access the ViewModel
    final subscriptionViewModel = Provider.of<SubcriptionViewModel>(context);
    // Use null-aware operators to prevent null pointer exceptions
    final subscriptions = subscriptionViewModel.subcriptions ?? [];
    final currentSubscription = subscriptionViewModel.userSubscription;
    // debugPrint("Check account: ${currentSubscription}");

    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 100),
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 70, top: 50),
          child: const Text(
            "Choose your plan",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Palette.darkText,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
        ),
        Column(
          children: [
            if ((currentSubscription?.subscription?.priorty ?? 0) >= 3)
              PackageInformation(
                packageName: currentSubscription!.subscription!.name ?? "",
                packagePrice: int.tryParse(
                        currentSubscription.subscription!.price ?? '0') ??
                    0,
                packagePriceUnit: "VND",
                packageButtonName: "Current Plan",
                buttonColor: Colors.grey,
                onTap: () {},
                featureList: currentSubscription.subscription!.features !=
                            null &&
                        currentSubscription.subscription!.features!.isNotEmpty
                    ? currentSubscription.subscription!.features!.split(", ")
                    : [],
              )
            else
              ...subscriptions.map((e) {
                final bool isLowerPlan =
                    (currentSubscription?.subscription?.priorty ?? 0) >
                        (e.priorty ?? 0);
                final bool isCurrentPlan =
                    currentSubscription?.subscriptionId == e.id;
                return PackageInformation(
                  packageName: e.name ?? "",
                  packagePrice: int.tryParse(e.price ?? '0') ?? 0,
                  packagePriceUnit: "VND",
                  packageButtonName: isCurrentPlan || isLowerPlan
                      ? (isLowerPlan ? "Downgrade Not Allowed" : "Current Plan")
                      : "Upgrade your plan",
                  buttonColor: isCurrentPlan || isLowerPlan
                      ? Colors.grey
                      : Palette.blueButton,
                  onTap: isCurrentPlan || isLowerPlan
                      ? () {}
                      : () async {
                          var request = CreatePayOsRequest(
                              amount: int.tryParse(e.price ?? '0') ?? 0,
                              description: e.name ?? "",
                              subscriptionName: e.name ?? "",
                              quantity: 1,
                              subcriptionId: e.id ?? "",
                              accountId: authVM.account?.id ?? "");
                          var payosQrResponse =
                              await subscriptionViewModel.getPayOsQr(request);
                          if (payosQrResponse != null) {
                            Navigator.pushNamed(context, AppRoutes.qrPayment,
                                arguments: {
                                  'qrCode': payosQrResponse.qrCode,
                                  'subscriptionId': e.id ?? "",
                                });
                          }
                        },
                  featureList: e.features != null && e.features!.isNotEmpty
                      ? e.features!.split(", ")
                      : [],
                );
              }).toList(),
          ],
        ),
      ],
    );
  }
}
