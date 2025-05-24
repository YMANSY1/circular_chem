import 'package:flutter/material.dart';

import '../../../core/models/company.dart';

class LeaderboardItem extends StatelessWidget {
  final int rank;

  const LeaderboardItem({
    Key? key,
    required this.rank,
    required this.company,
  }) : super(key: key);

  final Company company;

  Color _getRankColor() {
    switch (rank) {
      case 1:
        return Colors.amber.shade600;
      case 2:
        return Colors.grey.shade500;
      case 3:
        return Colors.orange.shade700;
      default:
        return Colors.blue.shade600;
    }
  }

  String _getRankSuffix() {
    if (rank >= 11 && rank <= 13) return '${rank}th';
    switch (rank % 10) {
      case 1:
        return '${rank}st';
      case 2:
        return '${rank}nd';
      case 3:
        return '${rank}rd';
      default:
        return '${rank}th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: rank <= 3
            ? Border.all(color: _getRankColor().withOpacity(0.3), width: 2)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Rank Badge
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getRankColor(),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _getRankColor().withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: rank <= 3
                    ? Icon(
                        rank == 1
                            ? Icons.looks_one
                            : rank == 2
                                ? Icons.looks_two
                                : Icons.looks_3,
                        color: Colors.white,
                        size: 20,
                      )
                    : Text(
                        '$rank',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 16),

            // Avatar
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: company.profilePicUrl != null
                  ? NetworkImage(company.profilePicUrl!)
                  : null,
              child: company.profilePicUrl == null
                  ? Icon(Icons.person, color: Colors.grey.shade600)
                  : null,
            ),
            const SizedBox(width: 16),

            // Player Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company.companyName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getRankSuffix(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Score
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${company.ecoPoints}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
