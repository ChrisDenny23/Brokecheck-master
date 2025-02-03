import 'package:flutter/material.dart';

void showAddCashbookModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return GestureDetector(
        onTap: () => FocusScope.of(context)
            .unfocus(), // Dismiss keyboard when tapping outside
        child: const AddCashbookModal(),
      );
    },
  );
}

class AddCashbookModal extends StatefulWidget {
  const AddCashbookModal({super.key});

  @override
  State<AddCashbookModal> createState() => _AddCashbookModalState();
}

class _AddCashbookModalState extends State<AddCashbookModal> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int? selectedIconIndex; // Track selected icon index

  // List of different payment-related icons
  final List<IconData> _icons = [
    Icons.account_balance_wallet,
    Icons.credit_card,
    Icons.monetization_on,
    Icons.attach_money,
    Icons.payments,
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {}); // Update UI when text field focus changes
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 15),

              // Title
              const Text(
                "Make a new cashbook",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'poppy',
                ),
              ),

              // *Divider Below Title*
              const SizedBox(height: 10),
              const Divider(thickness: 1, color: Colors.black26),
              const SizedBox(height: 20),

              // Cashbook Name TextField
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                cursorColor: Colors.greenAccent[100],
                decoration: InputDecoration(
                  labelText: "Cashbook Name",
                  labelStyle: TextStyle(
                    color: _focusNode.hasFocus ? Colors.green : Colors.black54,
                    fontFamily: 'poppy',
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Colors.green,
                    fontFamily: 'poppy',
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Choose Icon Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose an icon",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppy',
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Icon Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_icons.length, (index) {
                  bool isSelected = selectedIconIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIconIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? Colors.greenAccent[100]
                            : Colors.grey[400],
                        border: isSelected
                            ? Border.all(color: Colors.green, width: 2)
                            : null,
                      ),
                      child: Icon(
                        _icons[index], // Display different icons
                        color: Colors.black54,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),

              // Create Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _controller.text.trim().isEmpty
                      ? null // Disable button if input is empty
                      : () {
                          Navigator.pop(context);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent[100],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Create",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'poppy',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
