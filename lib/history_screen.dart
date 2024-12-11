// IM_2021_017 Sanduni Pandipperuma - Calculator Application - History Screen

import 'package:flutter/material.dart';

// Stateless widget representing the history screen
class HistoryScreen extends StatelessWidget {
  final List<String> history;                           // List to store history of calculations
  final VoidCallback onClearHistory;                    // Callback to notify parent

  // Constructor to initialize history and the callback
  const HistoryScreen({super.key, required this.history, required this.onClearHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar to display the screen title and action buttons
      appBar: AppBar(
        title: const Text("Calculation History"),
        backgroundColor: Colors.black,                // Dark theme
        actions: [
          // Button to clear the history
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              onClearHistory();                         // Notify parent to clear history
              Navigator.pop(context);                   // Close screen
            },
          ),
        ],
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                "No History Available",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          : ListView.builder(
            // Dynamically create list items based on history
              itemCount: history.length,
              itemBuilder: (context, index) {
                // Reverse the index for displaying the most recent entry at the top
                final reversedIndex = history.length - 1 - index; 
                return ListTile(
                  title: Text(
                    history[reversedIndex],
                    style: const TextStyle(color: Colors.white),
                  ),
                  leading: const Icon(Icons.history, color: Colors.white),
                );
              },
            ),
      backgroundColor: Colors.black,                 // Matches the app's dark theme
    );
  }
}
