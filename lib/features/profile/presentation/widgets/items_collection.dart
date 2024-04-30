import 'package:flutter/material.dart';

class ItemsCollection extends StatelessWidget {
  const ItemsCollection({
    super.key,
    required this.collectionTitle,
    required this.collectionItems,
  });

  final String collectionTitle;
  final List<Widget> collectionItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            collectionTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: collectionItems,
            ),
          )
        ],
      ),
    );
  }
}
