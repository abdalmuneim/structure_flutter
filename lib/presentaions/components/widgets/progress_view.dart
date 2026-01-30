import 'package:flutter/material.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/request_progress.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';

class ProgressView extends StatefulWidget {
  final bool showProgress;

  const ProgressView(this.showProgress, {super.key});

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 170,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.loadingBackground.withValues(alpha: .80),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          // appImage(AppAssets.appLogo),
          if (widget.showProgress)
            Column(
              children: [
                const SizedBox(height: 15),
                StreamBuilder(
                  stream: RequestProgress.requestProgress.stream,
                  initialData: "0",
                  builder: (context, progress) {
                    return Text(
                      "${progress.data}%",
                      style: const TextStyle(
                        color: AppColors.white,
                        fontFamily: "",
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
