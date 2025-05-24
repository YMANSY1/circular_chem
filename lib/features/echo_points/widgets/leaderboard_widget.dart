import 'package:flutter/material.dart';

import '../../../core/models/company.dart';
import 'leaderboard_item.dart';

class LeaderboardWidget extends StatelessWidget {
  final String title;

  const LeaderboardWidget({
    Key? key,
    this.title = 'Leaderboard',
    required this.companies,
  }) : super(key: key);

  final List<Company> companies;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple.shade50,
            Colors.indigo.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black87,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 8), // Add some spacing

                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.emoji_events,
                    color: Colors.amber.shade700,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: companies.length,
              itemBuilder: (context, index) {
                return LeaderboardItem(
                  rank: index + 1,
                  company: companies[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
