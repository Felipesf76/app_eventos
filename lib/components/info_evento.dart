import 'package:flutter/material.dart';
import '../views/event_details_view.dart';

class ListEvento extends StatelessWidget {
  final String title;
  final String description;

  const ListEvento({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      // onTap: () {
      //   Navigation.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => EventDetailsView(
      //         evento: ListEvento,
      //       )
      //     )
      //   )
      // }
      width: 200.0,
      height: 200.0,
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 4)),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: const Center(child: Icon(Icons.image, size: 100)),
          ),
          Container(
            width: 200.0,
            height: 100.0,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(description),
                const SizedBox(height: 4),
                Text(
                  'Description',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
