import 'package:flutter/material.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({super.key});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  int? selectedIndex; // For tracking selected payment mode

  final List<String> paymentModes = ["Cash", "Online", "Card"];

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Withdraw from cashbook",
          style: TextStyle(
            fontSize: 23,
            fontFamily: 'poppy',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
                context); // Use pop to go back instead of pushing a new route
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 40,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount Input
            _buildInputField("Amount"),
            const SizedBox(height: 20),

            // Category Input
            _buildInputField("Category"),
            const SizedBox(height: 20),

            // Description Input
            _buildInputField("Description"),
            const SizedBox(height: 20),

            // Date & Time Pickers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date Picker
                _buildDateTimePicker(
                  icon: Icons.calendar_month,
                  value:
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  onTap: _selectDate,
                ),

                // Time Picker
                _buildDateTimePicker(
                  icon: Icons.access_time,
                  value: selectedTime.format(context),
                  onTap: _selectTime,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Payment Mode Label
            const Text(
              'Payment Mode',
              style: TextStyle(
                fontFamily: 'poppy',
                color: Colors.black54,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 10),

            // Payment Mode Selection
            Wrap(
              spacing: 10, // Horizontal spacing between buttons
              children: List.generate(paymentModes.length, (index) {
                return ChoiceChip(
                  label: Text(
                    paymentModes[index],
                    style: TextStyle(
                      color: selectedIndex == index
                          ? Colors.black54
                          : Colors.purple,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  selected: selectedIndex == index,
                  onSelected: (selected) {
                    setState(() {
                      selectedIndex = selected ? index : null;
                    });
                  },
                  selectedColor: Colors.greenAccent[100],
                  backgroundColor: Colors.purple.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),

            // Save Buttons
            Center(
              child: Column(
                children: [
                  _buildSaveButton(
                    icon: Icons.file_copy_rounded,
                    label: "Save & add more",
                    onPressed: () {
                      // Save and add more logic
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildSaveButton(
                    icon: Icons.check,
                    label: "Save",
                    onPressed: () {
                      // Save logic
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build input fields
  Widget _buildInputField(String label) {
    return SizedBox(
      height: 60,
      child: TextField(
        style: const TextStyle(color: Colors.black54),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontFamily: 'poppy',
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black54),
            borderRadius: BorderRadius.circular(10),
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.green,
            fontFamily: 'poppy',
          ),
        ),
      ),
    );
  }

  // Helper method to build date/time pickers with dropdown arrow
  Widget _buildDateTimePicker({
    required IconData icon,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 53, 51, 51), size: 20),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              color: Color.fromARGB(255, 53, 51, 51),
              fontSize: 17,
              fontFamily: 'poppy',
            ),
          ),
          const SizedBox(width: 4), // Space between text and dropdown arrow
          const Icon(
            Icons.arrow_drop_down, // Dropdown arrow icon
            color: Color.fromARGB(255, 53, 51, 51),
            size: 20,
          ),
        ],
      ),
    );
  }

  // Helper method to build save buttons
  Widget _buildSaveButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(350, 60),
        foregroundColor: Colors.black,
        backgroundColor: Colors.greenAccent[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: Icon(icon, size: 35, color: Colors.black54),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'poppylight',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
