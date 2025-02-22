import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/app/app_routes.dart';
import 'package:panelway_mobile/core/widgets/back_page.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/core/widgets/custom_field.dart';
import 'dart:async';

class DateTimePickerScreen extends StatefulWidget {
  @override
  _DateTimePickerScreenState createState() => _DateTimePickerScreenState();
}

class _DateTimePickerScreenState extends State<DateTimePickerScreen> {
  int selectedDateIndex = 2; // Default selected date
  int selectedFromTimeIndex = 2; // Default "From time" index
  int selectedToTimeIndex = 2; // Default "To time" index
  String? _selectedRole;
  final List<String> dates = ['14', '13', '12', '11', '10', '09', '08'];
  final List<String> days = ['Mo', 'Tu', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<String> times = [
    '10:30 PM',
    '10:00 PM',
    '9:30 PM',
    '9:00 PM',
    '8:30 PM',
    '8:00 PM'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 40, left: 18.0, right: 18.0, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButtonCustom(
                context: context, backToRoute: AppRoutes.acLocationDetail),
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
                                      days[index % days.length],
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
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedToTimeIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Palette.whiteButton,
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
                              color: selectedToTimeIndex == index
                                  ? Palette.blueButton
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "Advertising content",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16),
                CustomDropDownList(
                    list: [],
                    hintText: "Your advertising content",
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    }),
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
                                arguments: 0);
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
                                    arguments: 0);
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
