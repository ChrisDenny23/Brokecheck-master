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

    setState(() {
      selectedDate = picked!;
    });
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
              Navigator.pushNamed(context, '/homepage');
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
              width: double.infinity,
              // Ensures full-width
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 20),

              // Amount Input
              SizedBox(
                height: 60,
                child: TextField(
                  style: const TextStyle(color: Colors.black54),
                  decoration: InputDecoration(
                    labelText: "Amount",
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
              ),

              const SizedBox(height: 20),

              // Category Input
              SizedBox(
                height: 60,
                child: TextField(
                  style: const TextStyle(color: Colors.black54),
                  decoration: InputDecoration(
                    labelText: "Category",
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
              ),

              const SizedBox(height: 20),

              // Description Input
              SizedBox(
                height: 60,
                child: TextField(
                  style: const TextStyle(color: Colors.black54),
                  decoration: InputDecoration(
                    labelText: "Description",
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
              ),

              const SizedBox(height: 20),

              // Date & Time Pickers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date Picker
                  GestureDetector(
                    onTap: _selectDate,
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month,
                            color: Color.fromARGB(255, 53, 51, 51), size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 53, 51, 51),
                            fontSize: 17,
                            fontFamily: 'poppy',
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Time Picker
                  GestureDetector(
                    onTap: _selectTime,
                    child: Row(
                      children: [
                        const Icon(Icons.access_time,
                            color: Color.fromARGB(255, 53, 51, 51), size: 20),
                        const SizedBox(width: 8),
                        Text(
                          selectedTime.format(context),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 53, 51, 51),
                            fontSize: 17,
                            fontFamily: 'poppy',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              // Payment Mode Label
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Payment Mode',
                  style: TextStyle(
                    fontFamily: 'poppy',
                    color: Colors.black54,
                    fontSize: 17,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Payment Mode Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(paymentModes.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? Colors.greenAccent[100]
                            : Colors.purple.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        paymentModes[index],
                        style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.black54
                              : Colors.purple,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(
                height: 220,
              ),
              Center(
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // save logic
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(350, 60),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.greenAccent[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Icon(
                        Icons.file_copy_rounded,
                        size: 35,
                        color: Colors.black54,
                      ),
                      label: Text(
                        "Save & add more",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'poppylight',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        // save logic
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(350, 60),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.greenAccent[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Icon(
                        Icons.check,
                        size: 35,
                        color: Colors.black54,
                      ),
                      label: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'poppylight',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
