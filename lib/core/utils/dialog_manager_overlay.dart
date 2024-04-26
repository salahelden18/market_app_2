import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class DialogManagerOverlay {
  static OverlayEntry? _overlayEntry;

  static void showDialogWithMessage(
    BuildContext context,
  ) {
    closeDialog();
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false; // Prevents going back when pressing the back button
          },
          child: GestureDetector(
            onTap: () {}, // Prevents dismiss on tap
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ), // Adjust the blur values as needed
                  child: Container(
                    color: Colors.black
                        .withOpacity(0.5), // Adjust the opacity as needed
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: BounceInDown(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 3,
                                offset: Offset(1, 1),
                                spreadRadius: 5,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CircularProgressIndicator(),
                                const SizedBox(width: 15),
                                Text(
                                  'loading',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void closeDialog() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
