import 'package:flutter/material.dart';

class DateTimePickerScreen extends StatefulWidget {
  @override
  _DateTimePickerScreenState createState() => _DateTimePickerScreenState();
}

class _DateTimePickerScreenState extends State<DateTimePickerScreen> {
  int selectedDateIndex = 2; // Default selected date
  int selectedFromTimeIndex = 2; // Default "From time" index
  int selectedToTimeIndex = 2; // Default "To time" index

  final List<String> dates = ['14', '13', '12', '11', '10', '09', '08'];
  final List<String> days = ['Mo', 'Tu', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<String> times = ['10:30 PM', '10:00 PM', '9:30 PM', '9:00 PM', '8:30 PM', '8:00 PM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              "Select date for meeting",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(dates.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDateIndex = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: selectedDateIndex == index
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.grey.shade200,
                              border: selectedDateIndex == index
                                  ? Border.all(color: Colors.blue, width: 2)
                                  : null,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  days[index % days.length],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedDateIndex == index
                                        ? Colors.blue
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  dates[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: selectedDateIndex == index
                                        ? Colors.blue
                                        : Colors.black,
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
            SizedBox(height: 24),
            Text(
              "From time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: selectedFromTimeIndex == index
                            ? Colors.blue.withOpacity(0.1)
                            : Colors.grey.shade200,
                        border: selectedFromTimeIndex == index
                            ? Border.all(color: Colors.blue, width: 2)
                            : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        times[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedFromTimeIndex == index
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "To time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: selectedToTimeIndex == index
                            ? Colors.blue.withOpacity(0.1)
                            : Colors.grey.shade200,
                        border: selectedToTimeIndex == index
                            ? Border.all(color: Colors.blue, width: 2)
                            : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        times[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedToTimeIndex == index
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}