import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/widgets/back_page.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/core/enum/bottom_bar_page.dart';
import 'dart:async';

class DateTimePickerScreen extends StatefulWidget {
  final String rentalLocationId;
  DateTimePickerScreen({super.key, required this.rentalLocationId});
  @override
  _DateTimePickerScreenState createState() => _DateTimePickerScreenState();
}

class _DateTimePickerScreenState extends State<DateTimePickerScreen> {
  int selectedDateIndex = 0; // Default selected date (today)
  int selectedFromTimeIndex = 0; // Default "From time" index (9 AM)
  int selectedToTimeIndex = 4; // Default "To time" index (11 AM)
  String? _selectedRole;
  
  // Lists to store dynamically generated dates, days and times
  late List<DateTime> dateObjects;
  late List<String> dates;
  late List<String> days;
  late List<String> times;
  
  @override
  void initState() {
    super.initState();
    // Generate dates, days and times
    _generateDates();
    _generateTimes();
  }
  
  void _generateDates() {
    // Generate 5 days starting from today
    dateObjects = List.generate(5, (index) {
      return DateTime.now().add(Duration(days: index));
    });
    
    // Format dates and days
    dates = dateObjects.map((date) => date.day.toString().padLeft(2, '0')).toList();
    days = dateObjects.map((date) {
      switch (date.weekday) {
        case 1: return 'Mon';
        case 2: return 'Tue';
        case 3: return 'Wed';
        case 4: return 'Thu';
        case 5: return 'Fri';
        case 6: return 'Sat';
        case 7: return 'Sun';
        default: return '';
      }
    }).toList();
  }
  
  void _generateTimes() {
    // Generate times from 9 AM to 5 PM with 30-minute intervals
    times = [];
    for (int hour = 9; hour <= 17; hour++) {
      final String period = hour < 12 ? 'AM' : 'PM';
      final int displayHour = hour > 12 ? hour - 12 : hour;
      times.add('$displayHour:00 $period');
      if (hour < 17) { // Don't add 5:30 PM
        times.add('$displayHour:30 $period');
      }
    }
  }
  
  // Function to check if a time is valid for "To time" selection
  bool isValidToTime(int index) {
    return index <= selectedFromTimeIndex;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Rental Location ID: ${widget.rentalLocationId}");
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 40, left: 18.0, right: 18.0, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButtonCustom(
                context: context, backToRoute: AppRoutes.acLocationDetail, id: widget.rentalLocationId,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Text(
                  "Select date for meeting",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 64),
                Text(
                  "Meeting date",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(dates.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    selectedDateIndex = index;
                                  },
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                padding: EdgeInsets.only(top: 14),
                                decoration: BoxDecoration(
                                  color: Palette.whiteButton,
                                  border: selectedDateIndex == index
                                      ? Border.all(
                                          color: Palette.blueButton, width: 2)
                                      : Border.all(
                                          color: Palette.borderButton,
                                          width: 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: 83,
                                height: 96,
                                child: Column(
                                  children: [
                                    Text(
                                      days[index],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: selectedDateIndex == index
                                            ? Palette.blueButton
                                            : Palette.darkText,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      dates[index],
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: selectedDateIndex == index
                                            ? Palette.blueButton
                                            : Palette.darkText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  "From time",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(times.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFromTimeIndex = index;
                            // Reset To time if it's earlier than From time
                            if (selectedToTimeIndex < selectedFromTimeIndex) {
                              selectedToTimeIndex = selectedFromTimeIndex + 1;
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Palette.whiteButton,
                            border: selectedFromTimeIndex == index
                                ? Border.all(
                                    color: Palette.blueButton, width: 2)
                                : Border.all(
                                    color: Palette.borderButton, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            times[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: selectedFromTimeIndex == index
                                  ? Palette.blueButton
                                  : Palette.darkText,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "To time",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(times.length, (index) {
                      // Disable selection of earlier times than From time
                      bool isDisabled = index <= selectedFromTimeIndex;
                      return GestureDetector(
                        onTap: isDisabled
                            ? null
                            : () {
                                setState(() {
                                  selectedToTimeIndex = index;
                                });
                              },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isDisabled
                                ? Palette.borderButton.withOpacity(0.3)
                                : Palette.whiteButton,
                            border: selectedToTimeIndex == index
                                ? Border.all(
                                    color: Palette.blueButton, width: 2)
                                : Border.all(
                                    color: Palette.borderButton, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            times[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDisabled
                                  ? Palette.darkText.withOpacity(0.5)
                                  : selectedToTimeIndex == index
                                      ? Palette.blueButton
                                      : Palette.darkText,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 32),
                // Text(
                //   "Advertising content",
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                // ),
                // SizedBox(height: 16),
                // CustomDropDownList(
                //     list: [],
                //     hintText: "Your advertising content",
                //     onChanged: (value) {
                //       setState(() {
                //         _selectedRole = value;
                //       });
                //     }),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: CustomButton(
            functionName: "Next",
            onPressed: () {
              int countdown = 3; // Countdown starts at 3 seconds
              late Timer timer;
              showDialog(
                context: context,
                barrierDismissible:
                    false, // Prevents closing by tapping outside
                builder: (BuildContext dialogContext) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      // Start countdown when the dialog is built
                      timer = Timer.periodic(Duration(seconds: 1), (t) {
                        if (!context.mounted) {
                          t.cancel();
                          return;
                        }

                        if (countdown > 1) {
                          setState(() {
                            countdown--;
                          });
                        } else {
                          t.cancel();
                          if (dialogContext.mounted) {
                            Navigator.pop(dialogContext);
                            Navigator.pushNamed(context, AppRoutes.bottombar,
                                arguments: BottomBarPage.home.index);
                          }
                        }
                      });

                      return AlertDialog(
                        title: Container(
                          margin: EdgeInsets.only(bottom: 25.0),
                          child: Text(
                            "Booking successfully",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        content: Container(
                          margin: EdgeInsets.only(bottom: 25.0),
                          child: Text(
                            ("Your booking request has been sent to the space provider.\n\n"
                             + "Redirecting to main menu in $countdown seconds..."),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Palette.darkText,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        actions: [
                          CustomButton(
                              functionName: "Back to main menu",
                              onPressed: () {
                                timer.cancel();
                                if (dialogContext.mounted) {
                                  Navigator.pop(dialogContext);
                                }
                                Navigator.pushNamed(
                                    context, AppRoutes.bottombar,
                                    arguments: BottomBarPage.home.index);
                              },
                              buttonBackgroundColor: Palette.blueButton,
                              textColor: Palette.white)
                        ],
                      );
                    },
                  );
                },
              ).then((_) {
                if (timer.isActive) {
                  timer.cancel();
                }
              });
            },
            buttonBackgroundColor: Palette.blueButton,
            textColor: Palette.lightText),
      ),
    );
  }
}