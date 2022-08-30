import 'package:flutter/material.dart';
import 'package:the_fair_players_administration/modules/core/theme/app_colors.dart';

class ConfirmationDialog {
  static showDeleteDialog(BuildContext context, {required Function() action}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Delete Confirmation",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            content: Text("Are you sure you want to delete?",
                style: Theme.of(context).textTheme.bodyMedium),
            actions: [
              TextButton(
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: AppColors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                onPressed: () {
                  action();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: AppColors.redAccent),
                ),
              ),
            ],
          );
        });
  }
}
