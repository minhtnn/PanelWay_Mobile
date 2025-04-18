import 'package:flutter/material.dart';
import 'package:panelway_mobile/app/app_palette.dart';
import 'package:panelway_mobile/core/widgets/custom_button.dart';
import 'package:panelway_mobile/data/payloads/responses/accountResponse.dart';


class ContactInfo extends StatefulWidget {
  final bool showPhoneNumber;
  final AccountResponse account;
  const ContactInfo({super.key, 
    this.showPhoneNumber = false, 
    required this.account,
  });

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  bool isPhoneNumberAvailable = false;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(style: BorderStyle.solid, color: Palette.spacer)),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              "Contact information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.account.fullName ?? 'Not Available',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Contact for more details'),
                ],
              ),
              const SizedBox(width: 20),
              CircleAvatar(
                radius: 30,
                backgroundColor: Palette.grey,
              ),
            ],
          ),
          const SizedBox(height: 24),
          CustomButton(
            functionName: isPhoneNumberAvailable
                ? (widget.account.phoneNumber ?? 'No phone number')
                : 'Upgrade to get',
            onPressed: (){
              if (!widget.showPhoneNumber) {
                // Handle phone number action
                showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Upgrade Required"),
                          content: const Text(
                              "You need to upgrade your plan to contact the space provider."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
              } else {
                setState(() {
                  isPhoneNumberAvailable = widget.showPhoneNumber;
                });
              }
            },
            buttonBackgroundColor: Palette.buttonGrayTransparent,
            textColor: Palette.deactivatedText,
            icon: Icons.phone,
          ),
        ],
      ),
    );
  }
}

// class ContactInfo extends StatelessWidget {
//   final bool showPhoneNumber;
//   final AccountResponse account;
//   final VoidCallback onPressed;
  
//   ContactInfo({
//     super.key, 
//     bool? showPhoneNumber,
//     required this.account, 

//   }) : this.showPhoneNumber = showPhoneNumber ?? false;

//   @override
//   Widget build(BuildContext context) {
    
//   }
// }

