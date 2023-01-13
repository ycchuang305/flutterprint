import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterprint/features/backend_environment/application/host_controller.dart';

/// Show a debug banner that indicates the current backend environment
class BackendEnvBanner extends ConsumerWidget {
  final Widget child;
  const BackendEnvBanner({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerName =
        ref.watch(hostControllerProvider.select((state) => state.bannerName));
    return bannerName.isEmpty
        ? child
        : Banner(
            key: Key(bannerName),
            location: BannerLocation.bottomEnd,
            message: bannerName,
            child: child,
          );
  }
}
