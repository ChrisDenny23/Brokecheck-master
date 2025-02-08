import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// Flutter code sample for [ExpansionPanelList].

class Accordion extends StatefulWidget {
  const Accordion({super.key});

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  //TODO: Make constructor

  String AccordionTitle = "Netflix";
  String RenewDate = "1 Jan 25";
  String SubscriptionType = "Annual Subscription";
  String PurchaseDate = "1 Jan 25";
  int SubscriptionAmount = 4900;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: ScrollMotion(), children: [
        SizedBox(width: 5),
        SlidableAction(
          borderRadius: BorderRadius.circular(15),
          onPressed: ((context) {}),
          backgroundColor: Color.fromRGBO(60, 52, 202, 1),
          icon: Icons.edit,
        ),
        SizedBox(width: 5),
        SlidableAction(
          onPressed: ((context) {}),
          borderRadius: BorderRadius.circular(15),
          backgroundColor: Color.fromRGBO(241, 5, 5, 1),
          icon: Icons.delete,
        ),
      ]),
      child: ClipRRect(
        //* To Create rounded corners

        borderRadius: BorderRadius.circular(15), // Apply rounded corners here
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(
                248, 248, 248, 1), // Optional: To make it white background
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ExpansionPanelList(
            //! Resposible for Opening and closing
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (index, isExpanded) {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                backgroundColor: Colors.white, //! Color of the accordion
                isExpanded: _isExpanded,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0), // Same padding
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("images/pfp.jpg"),
                        radius: 25,
                      ),
                      title: Text(AccordionTitle,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: Text(
                        'Renews on: $RenewDate',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                      trailing: Text('\$$SubscriptionAmount',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black)));
                },
                body: Padding(
                  //! Bottom part
                  padding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8), // Same padding as ListTile
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(height: 1, color: Colors.grey),
                      SizedBox(height: 10), // Spacing after divider
                      Text(SubscriptionType,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Purchased on',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600])),
                          Text(PurchaseDate,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600])),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Renews on',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600])),
                          Text(RenewDate,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
