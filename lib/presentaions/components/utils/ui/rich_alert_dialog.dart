import 'package:flutter/material.dart';
import 'package:structure_flutter/presentaions/components/widgets/app_button.dart';
import '../../extensions/builder_extension.dart';

enum DialogSize { height, medium, small }

class RichAlertDialog extends StatefulWidget {
  /// The title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  /// Usually has a bigger fontSize than the [alertSubtitle].
  final String? alertTitle;

  /// The subtitle of the dialog is displayed in a medium-sized font beneath
  /// the title of the dialog.
  ///
  /// Usually has a smaller fontSize than the [alertTitle]
  final String? alertSubtitle;

  /// The type of dialog, whether warning, success or error.
  final int? alertType;

  /// The (optional) actions to be performed in the dialog is displayed
  /// the subtitle of the dialog. If no values are provided, a default
  /// [Button] widget is rendered.
  ///
  /// Typically a [List<Widget>] widget.
  final List<Widget>? actions;

  /// Specifies how blur the screen overlay effect should be.
  /// Higher values mean more blurred overlays.
  final double? blurValue;

  // Specifies the opacity of the screen overlay
  final double? backgroundOpacity;

  /// (Optional) User defined icon for the dialog. Advisable to use the
  /// default icon matching the dialog type.
  final Icon? dialogIcon;

  final DialogSize? dialogSize;

  const RichAlertDialog({
    super.key,
    required this.alertTitle,
    required this.alertSubtitle,
    this.alertType,
    required this.actions,
    this.blurValue,
    this.backgroundOpacity,
    this.dialogIcon,
    this.dialogSize = DialogSize.medium,
  });

  @override
  createState() => _RichAlertDialogState();
}

class _RichAlertDialogState extends State<RichAlertDialog> {
  late double deviceWidth;
  late double deviceHeight;
  late double dialogHeight;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size screenSize = MediaQuery.of(context).size;

    deviceWidth = orientation == Orientation.portrait
        ? screenSize.width
        : screenSize.height;
    deviceHeight = orientation == Orientation.portrait
        ? screenSize.height
        : screenSize.width;
    if (widget.dialogSize == DialogSize.small) {
      dialogHeight = deviceHeight * (1 / 5);
    } else {
      dialogHeight = deviceHeight * (2 / 5);
    }

    return Center(
      child: Wrap(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  width: deviceWidth * 0.9,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: widget.dialogSize == DialogSize.small
                              ? 20
                              : 60,
                        ),
                        if (widget.alertTitle != null)
                          Text(
                            widget.alertTitle!,
                            style: widget.alertSubtitle == null
                                ? Theme.of(
                                    context,
                                  ).textTheme.titleLarge!.copyWith(fontSize: 18)
                                : Theme.of(context).textTheme.titleLarge,
                          ),
                        if (widget.alertSubtitle != null)
                          Column(
                            children: [
                              SizedBox(height: dialogHeight / 10),
                              Text(
                                widget.alertSubtitle!,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        SizedBox(height: dialogHeight / 10),
                        widget.actions != null
                            ? _buildActions()
                            : _defaultAction(context),
                        SizedBox(height: dialogHeight / 10),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: widget.dialogIcon != null
                    ? widget.dialogIcon!
                    : _defaultIcon(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(mainAxisSize: MainAxisSize.min, children: widget.actions!);
  }

  Widget _defaultIcon() {
    return const SizedBox.shrink();
  }

  Container _defaultAction(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AppButton(minWidth: 200, onPressed: () => pop(), title: "GOT IT"),
    );
  }
}

Text richTitle(String title) {
  return Text(title, style: const TextStyle(fontSize: 24.0));
}

Text richSubtitle(String subtitle) {
  return Text(subtitle, style: const TextStyle(color: Colors.grey));
}

class RichAlertType {
  /// Indicates an error dialog by providing an error icon.
  static const int ERROR = 0;

  /// Indicates a success dialog by providing a success icon.
  static const int SUCCESS = 1;

  /// Indicates a warning dialog by providing a warning icon.
  static const int WARNING = 2;
}
