import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

/// Helper class for showing custom snack-bars.
class SnackBarHelper {
  const SnackBarHelper._();

  /// Global key for accessing the ScaffoldMessengerState.
  static final _key = GlobalKey<ScaffoldMessengerState>();

  /// Getter for the global key.
  static GlobalKey<ScaffoldMessengerState> get key => _key;

  /// Method to show a custom snackbar.
  ///
  /// [title] The title of the snackbar.
  /// [message] The message of the snackbar.
  /// [contentType] The type of content for the snackbar.
  static void showSnackBar(
          {String? title, String? message, ContentType? contentType}) =>
      _key.currentState // Access the ScaffoldMessengerState
        ?..removeCurrentSnackBar() // Remove any existing snack-bars
        ..showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent, // Transparent background
            elevation: 0, // No elevation
            content: SizedBox(
              height: 100,
              child: AwesomeSnackbarContent(
                title: title ?? "", // Default to empty string if null
                message: message ?? "", // Default to empty string if null
                contentType: contentType ??
                    ContentType.help, // Default to help content type if null
              ),
            ),
            behavior: SnackBarBehavior.floating, // Floating behavior
          ),
        );
}
