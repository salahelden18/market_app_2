import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = 'search-screen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: const Center(child: Text('Search Screen')),
    );
  }
}
