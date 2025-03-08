import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
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
      Provider.of<SubcriptionViewModel>(context, listen: false)
          .getSubcriptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _subcriptionViewModel = Provider.of<SubcriptionViewModel>(context);
    var subcriptions = _subcriptionViewModel.subcriptions;
    return ListView(
      padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 100),
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 70, top: 50),
          child: Text(
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
            ...subcriptions?.map((e) {
                  return PackageInformation(
                    packageName: e.name ?? "",
                    packagePrice: int.tryParse(e.price ?? '0') ?? 0,
                    packagePriceUnit: "VND",
                    packageButtonName: "Upgrade your plan",
                    buttonColor: Palette.blueButton,
                    onTap: () {},
                    featureList: e.features != null && e.features!.isNotEmpty
                        ? e.features!.split(", ")
                        : [],
                  );
                }).toList() ??
                [],
          ],
        ),
      ],
    );
  }
}

// class PackagePlan extends StatelessWidget {
//   const PackagePlan({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<String> freeFeatures = [
//       "10 searches and view available advertising locations",
//       "Basic filters by area and rental price",
//       "Get the first 5 bookings for free",
//       "Basic filters by area and rental price."
//     ];
//     return ListView(
//       padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 100),
//       children: [
//         Container(
//           margin: EdgeInsets.only(bottom: 70, top: 50),
//           child: Text(
//             "Choose your plan",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 color: Palette.darkText,
//                 fontSize: 24,
//                 fontWeight: FontWeight.w600),
//           ),
//         ),
//         PackageInformation(
//             packageName: "Free",
//             packagePrice: 0,
//             packagePriceUnit: "VND",
//             packageButtonName: "Your current plan",
//             buttonColor: Palette.grayTransparent,
//             onTap: () {},
//             featureList: freeFeatures),
//         const SizedBox(height: 80,),
//         PackageInformation(
//             packageName: "Standard",
//             packagePrice: 300000,
//             packagePriceUnit: "VND",
//             packageButtonName: "Upgrade your plan",
//             buttonColor: Palette.blueButton,
//             onTap: () {},
//             featureList: freeFeatures),
//       ],
//     );
//   }
// }
