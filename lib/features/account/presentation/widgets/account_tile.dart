import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/shared/widgets/progress.dart';
import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:flutter/material.dart';

class AccountTile extends StatelessWidget {
  final String? profilePicture;
  final String? name;
  final String? email;

  const AccountTile({
    super.key,
    required this.email,
    required this.name,
    required this.profilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserProfileImage(profilePicture: profilePicture),
        const SizedBox(height: AppDimen.p16),
        UserProfileInformations(email: email, name: name)
      ],
    );
  }
}

class UserProfileImage extends StatelessWidget {
  final String? profilePicture;
  const UserProfileImage({
    super.key,
    required this.profilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: profilePicture!,
        fit: BoxFit.cover,
        width: 140,
        height: 140,
        placeholder: (context, url) {
          return const Progress();
        },
        errorWidget: (context, url, error) {
          return const Icon(Icons.error);
        },
      ),
    );
  }
}

class UserProfileInformations extends StatelessWidget {
  final String? name;
  final String? email;
  const UserProfileInformations(
      {super.key, required this.email, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name!,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppDimen.p2),
        Text(
          email!,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColor.greyColor),
        ),
      ],
    );
  }
}
