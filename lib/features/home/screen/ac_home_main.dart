import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/enum/bottom_bar_page.dart';
import 'package:panelway_mobile/core/enum/user_role.dart';
import 'package:panelway_mobile/features/auth/view_models/auth_viewmodel.dart';
import 'package:panelway_mobile/features/home/view_models/rental_location_viewmodel.dart';
import 'package:panelway_mobile/features/home/widgets/advertisement_card%20.dart';
import 'package:panelway_mobile/features/home/widgets/icon_navigation.dart';
import 'package:provider/provider.dart';

class ACHomeMain extends StatefulWidget {
  final int bottomBarIndex;
  const ACHomeMain({super.key, required this.bottomBarIndex});

  @override
  State<ACHomeMain> createState() => _ACHomeMainState();
}

class _ACHomeMainState extends State<ACHomeMain> {
  bool _initialLoadDone = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Only load data once when widget is created
    _loadDataOnce();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
  final viewModel = Provider.of<RentalLocationViewmodel>(context, listen: false);

  // Add debug print to verify this method is being called
  // debugPrint("Scrolling: ${_scrollController.position.pixels}/${_scrollController.position.maxScrollExtent}");
  
  // Check if we're at least 80% through the list
  if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8 && 
      !viewModel.isLoadingMore &&
      !viewModel.isLoading &&
      viewModel.hasMorePages) {
    
    debugPrint("LOADING MORE DATA NOW");
    // Make sure this method actually triggers a state update in the viewModel
    viewModel.loadMoreRentalLocations();
  }
}

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll); // Remove listener
    _scrollController.dispose(); // Dispose controller
    super.dispose();
  }

  void _loadDataOnce() {
    if (!_initialLoadDone) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<RentalLocationViewmodel>(context, listen: false)
            .getRentalLocationPaging();
        Provider.of<AuthViewModel>(context, listen: false).getAccount();
        final authVM = Provider.of<AuthViewModel>(context, listen: false);
        authVM.getAccount().then((_) {
          if (mounted) {
            setState(() {}); // Force refresh if needed
          }
        });
        _initialLoadDone = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    var account = authViewModel.account;
    final rentalLocationViewModel =
        Provider.of<RentalLocationViewmodel>(context);
    if (rentalLocationViewModel.rentalLocationPaging != null &&
        rentalLocationViewModel.rentalLocationPaging!.items.isNotEmpty &&
        rentalLocationViewModel
                .rentalLocationPaging!.items[0].rentalLocationImages !=
            null &&
        rentalLocationViewModel
            .rentalLocationPaging!.items[0].rentalLocationImages!.isNotEmpty) {}
    return Container(
      // Consider Scaffold if this is a full screen
      child: Align(
        alignment: Alignment.center,
        // Use ListView.builder for better performance with potentially long lists
        child: ListView.builder(
          controller: _scrollController, // Attach the controller
          padding:
              EdgeInsets.only(top: 20, left: 30.0, right: 30.0, bottom: 80.0),
          // Calculate item count: existing items + 1 for loading indicator if needed
          itemCount:
              (rentalLocationViewModel.rentalLocationPaging?.items.length ??
                      0) +
                  (rentalLocationViewModel.isLoadingMore ? 1 : 0) +
                  ((rentalLocationViewModel.isLoading &&
                          (rentalLocationViewModel
                                  .rentalLocationPaging?.items.isEmpty ??
                              true))
                      ? 1
                      : 0) +
                  ((rentalLocationViewModel.error != null &&
                          (rentalLocationViewModel
                                  .rentalLocationPaging?.items.isEmpty ??
                              true))
                      ? 1
                      : 0),

          itemBuilder: (context, index) {
            final items = rentalLocationViewModel.rentalLocationPaging?.items;
            final itemCount = items?.length ?? 0;
            final isLoadingInitial = rentalLocationViewModel.isLoading && itemCount == 0;
            final isErrorInitial = rentalLocationViewModel.error != null && itemCount == 0;
            final isEmptyInitial = !rentalLocationViewModel.isLoading && itemCount == 0 && rentalLocationViewModel.error == null;
            final isLoadingMore = rentalLocationViewModel.isLoadingMore;
            // --- Header Section (Rendered only once at the top) ---
            if (index == 0) {
              return Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align header content left
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleIconNavigation(
                              color: Palette.grey,
                              iconData: Symbols.notifications_none,
                              iconWeight: 400,
                              onTap: () {
                                Navigator.popAndPushNamed(
                                    context, AppRoutes.bottombar,
                                    arguments:
                                        BottomBarPage.notifications.index);
                              }),
                          const SizedBox(width: 15),
                          CircleIconNavigation(
                              color: Palette.grey,
                              iconData: Symbols.map,
                              iconWeight: 400,
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.acMap,
                                    arguments: widget.bottomBarIndex);
                              }),
                        ],
                      ),
                      // ... (Your Location Dropdown) ...
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              Positioned(
                                child: Text("location"),
                                top: 5,
                                right: 5,
                              ),
                              Positioned(
                                child: Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                ),
                                top: 30,
                                right: 0,
                              ),
                              DropdownButton(
                                padding: EdgeInsets.only(right: 20, top: 16),
                                icon: const SizedBox(),
                                underline: const SizedBox(),
                                value:
                                    'All locations', // Make this dynamic if needed
                                items: [
                                  DropdownMenuItem(
                                    child: Text('All locations'),
                                    value: 'All locations',
                                  ),
                                ],
                                onChanged: (value) {
                                  // Handle location change
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // --- Search Bar and Add Button ---
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Symbols.search,
                                    color: Palette.grayTransparent),
                                hintText: 'Search for...',
                                hintStyle:
                                    TextStyle(color: Palette.grayTransparent),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  borderSide: BorderSide(
                                    color: Palette.chipBackground,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  borderSide: BorderSide(
                                    color: Palette.chipBackground,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  borderSide: BorderSide(
                                    color: Palette.blueButton,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.all(16),
                              child: Icon(
                                Symbols.add,
                                color: Palette.white,
                                weight: 700,
                              ),
                              decoration: BoxDecoration(
                                color: Palette.blueButton,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onTap: () {
                              if (account != null) {
                                if (account.role ==
                                    UserRoleEnum.AdvertisingClient.name) {
                                  Navigator.pushNamed(
                                      context, AppRoutes.uploadContent);
                                }
                                if (account.role ==
                                    UserRoleEnum.SpaceProvider.name) {
                                  Navigator.pushNamed(
                                      context, AppRoutes.uploadSpace);
                                }
                              }
                            },
                          ),
                        ],
                      )),
                  SizedBox(height: 16.0),
                  // --- Initial Loading/Error/Empty States ---
                  if (isLoadingInitial)
                    const Center(
                        child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: CircularProgressIndicator()))
                  else if (isErrorInitial)
                    Center(
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                                "Error: ${rentalLocationViewModel.error}")))
                  else if (isEmptyInitial)
                    const Center(
                        child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("No items found")))
                  // Removed the SizedBox.shrink() here as it wasn't necessary
                ],
              );
            }

            // --- Calculate index for the actual data list ---
            // Subtract 1 because the header takes up index 0
            int dataIndex = index - 1;

            // --- Render List Items ---
            if (items != null && dataIndex < itemCount) {
               // Check if the dataIndex is valid for the items list
              return _buildAdvertisementCard(
                  rentalLocationViewModel, dataIndex); // Use helper
            }
            // --- Render Loading More Indicator at the very end ---
            else if (isLoadingMore && index == itemCount + 1 -1) { // Check if it's the last item index (itemCount because index is 0-based)
              // index == itemCount means it's the item *after* the last data item
               return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0), // Add more padding
                  child: Center(child: CircularProgressIndicator()),
                );
            }
            // --- Fallback ---
            else {
              // Should not happen with correct itemCount calculation
              debugPrint("ListView.builder reached unexpected index: $index with itemCount: $itemCount, isLoadingMore: $isLoadingMore");
              return const SizedBox.shrink();
            }
          },
        
        ),
      ),
    );
  }

  Widget _buildAdvertisementCard(RentalLocationViewmodel viewModel, int index) {
    final e = viewModel.rentalLocationPaging!.items[index];
    return AdvertisementCard(
      // key: ValueKey(e.id ?? index), // Add a key for better list performance
      rentalLocationId: e.id ?? "",
      imageUrl: (e.rentalLocationImages != null &&
              e.rentalLocationImages!.isNotEmpty &&
              e.rentalLocationImages![0].imageUrl !=
                  null) // Extra null check for safety
          ? e.rentalLocationImages![0].imageUrl!
          : "", // Provide a default empty string or placeholder URL
      title: e.code ?? "No title",
      location: e.address ?? "No location",
      price: '${e.price ?? 0}',
      minDuration: '${1}', // Assuming this is fixed or comes from `e` later
      traffic: e.description ?? "No description",
      type: e.panelSize ?? "Unavailable",
    );
  }
}
