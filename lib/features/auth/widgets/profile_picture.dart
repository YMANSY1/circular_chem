import 'package:circular_chem_app/features/auth/widgets/change_name_dialog.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    this.profilePictureUrl,
    required this.onUpdateSuccess,
  });

  final String? profilePictureUrl;
  final VoidCallback onUpdateSuccess;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              profilePictureUrl ??
                  'https://via.placeholder.com/150', // Placeholder image
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 18,
                icon: Icon(Icons.edit, color: Colors.grey[700]),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return ChangeFieldDialog(
                        newValueController: TextEditingController(),
                        currentValue: profilePictureUrl ?? 'None',
                        onUpdateSuccess: onUpdateSuccess,
                        valueName: 'Profile Picture',
                        fieldName: 'profile_picture_url',
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
