import 'package:flutter/material.dart';

import '../../../theme/theme.dart';
import '../router/router_context_extension.dart';
import '../shared/app_buttons.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Oops!',
                  style: AppTextStyles.h1,
                ),
                const SizedBox(height: 10),
                Text(
                  "The page you are looking for doesn't seem to exist.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3,
                ),
                const SizedBox(height: 30),
                AppButtons.primary(
                  width: 200,
                  onTap: context.replaceHome,
                  child: const Text('Go Home'),
                ),
              ],
            ),
          ),
        ),
      );
}
