import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:structure_flutter/presentaions/components/utils/ui/ui.dart';
import 'package:structure_flutter/presentaions/components/widgets/outline_input_border.dart';

Widget dropDown<T>({
  String? title,
  required List<T> list,
  String? hint,
  String? label,
  Color hintColor = AppColors.grey,
  T? selectedItem,
  double height = 300,
  dynamic errorHeight,
  bool isFirst = true,
  final Widget Function(T data)? itemBuilder,
  final Widget Function(T? data)? dropdownBuilder,
  FormFieldValidator<T>? validator,
  FormFieldValidator<List<T>>? validatorList,
  List<T>? selectedItems, // For multi-selection
  Function(List<T> data)? onMultiSelect,
  Function(T data)? onSelect,
  bool showSearchBox = true,
  Mode mode = Mode.form,
  InputDecoration? inputDecoration,
  bool isRequired = false,
  bool canNotBeEmpty = false,
  Function? onClickWillNull,
  bool isMultiSelection = false,
  bool enabled = true,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != null)
        Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 3),
          ],
        ),
      GestureDetector(
        onTap: () {
          if (onClickWillNull != null) {
            onClickWillNull();
          }
        },
        child: isMultiSelection
            ? AbsorbPointer(
                absorbing: canNotBeEmpty || !enabled,
                child: DropdownSearch<T>.multiSelection(
                  items: (filter, loadProps) => list,
                  selectedItems: isMultiSelection ? selectedItems! : [],
                  popupProps: PopupPropsMultiSelection.modalBottomSheet(
                    modalBottomSheetProps: const ModalBottomSheetProps(
                      elevation: 0,
                      backgroundColor: AppColors.hide,
                    ),
                    searchFieldProps: TextFieldProps(
                      padding: const EdgeInsets.all(15),
                      decoration: dropDownLabelDecoration("search", isRequired),
                      style: const TextStyle(color: AppColors.secondary),
                    ),
                    showSearchBox: showSearchBox,
                    searchDelay: const Duration(seconds: 0),
                    constraints: BoxConstraints(maxHeight: height),
                    emptyBuilder: (context, data) {
                      return Center(
                        child: Text(
                          "no_data_found",
                          style: const TextStyle(color: AppColors.secondary),
                        ),
                      );
                    },
                    itemBuilder: (context, item, b, bool isSelected) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: itemBuilder != null
                            ? itemBuilder(item)
                            : Text(item.toString()),
                      );
                    },
                    containerBuilder: (ctx, popupWidget) {
                      return SafeArea(
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                            start: 16,
                            end: 16,
                            bottom: 16,
                            top: 0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.white,
                          ),
                          child: popupWidget,
                        ),
                      );
                    },
                  ),

                  onChanged: (items) {
                    if (isMultiSelection) {
                      if (onMultiSelect != null) {
                        onMultiSelect(items);
                      }
                    } else if (items.isNotEmpty) {
                      if (onSelect != null) {
                        onSelect(items.first);
                      }
                    }
                  },
                  validator: validatorList,
                  suffixProps: DropdownSuffixProps(
                    dropdownButtonProps: DropdownButtonProps(
                      isVisible: enabled,
                      iconOpened: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.black,
                      ),
                      iconClosed: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  dropdownBuilder: (context, selectedItems) {
                    return Text(
                      selectedItems.join(", "),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    );
                  },
                  decoratorProps: DropDownDecoratorProps(
                    decoration:
                        inputDecoration ??
                        (label != null
                            ? dropDownLabelDecoration(label, isRequired)
                            : dropDownHintDecoration(hint)),
                  ),
                ),
              )
            : AbsorbPointer(
                absorbing: canNotBeEmpty || !enabled,
                child: DropdownSearch<T>(
                  items: (filter, loadProps) => list,
                  popupProps: PopupProps.modalBottomSheet(
                    modalBottomSheetProps: const ModalBottomSheetProps(
                      elevation: 0,
                      backgroundColor: AppColors.hide,
                    ),
                    searchFieldProps: TextFieldProps(
                      padding: const EdgeInsets.all(15),
                      decoration: dropDownLabelDecoration(
                        "search...",
                        isRequired,
                      ),
                      style: const TextStyle(color: AppColors.secondary),
                    ),
                    showSearchBox: showSearchBox,
                    searchDelay: const Duration(seconds: 0),
                    constraints: BoxConstraints(maxHeight: height),
                    emptyBuilder: (context, data) {
                      return Center(
                        child: Text(
                          "no_data_found",
                          style: const TextStyle(color: AppColors.secondary),
                        ),
                      );
                    },
                    itemBuilder: (context, item, b, bool isSelected) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: itemBuilder != null
                            ? itemBuilder(item)
                            : Text(item.toString()),
                      );
                    },
                    containerBuilder: (ctx, popupWidget) {
                      return SafeArea(
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                            start: 16,
                            end: 16,
                            bottom: 16,
                            top: 0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.white,
                          ),
                          child: popupWidget,
                        ),
                      );
                    },
                  ),
                  decoratorProps: DropDownDecoratorProps(
                    decoration:
                        inputDecoration ??
                        (label != null
                            ? dropDownLabelDecoration(label, isRequired)
                            : dropDownHintDecoration(hint)),
                  ),
                  selectedItem: selectedItem,
                  onChanged: (item) {
                    // onChanged: (T item) {
                    selectedItem = item as T;
                    if (onSelect != null) {
                      onSelect(item);
                    }
                    // },
                  },
                  validator: validator,
                  suffixProps: DropdownSuffixProps(
                    dropdownButtonProps: DropdownButtonProps(
                      isVisible: enabled,
                      iconOpened: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.black,
                      ),
                      iconClosed: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  dropdownBuilder: (context, selectedItems) {
                    if (dropdownBuilder != null) {
                      return dropdownBuilder(selectedItems);
                    }
                    return Text(
                      selectedItems != null ? selectedItems.toString() : "",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    );
                  },
                ),
              ),
      ),
    ],
  );
}

InputDecoration dropDownLabelDecoration(String? label, bool isRequired) {
  return InputDecoration(
    border: AppOutlineInputBorder(
      color: AppColors.grey.withValues(alpha: .30),
      isReadOnly: false,
    ),
    focusedBorder: AppOutlineInputBorder(
      color: AppColors.grey.withValues(alpha: .30),
      isReadOnly: false,
    ),
    enabledBorder: AppOutlineInputBorder(
      color: AppColors.grey.withValues(alpha: .30),
      isReadOnly: false,
    ),
    contentPadding: const EdgeInsetsDirectional.only(
      start: 15.0,
      end: 0,
      bottom: 4.5,
    ),
    fillColor: AppColors.fourth,
    filled: true,
    // hintText: label,
    label: label != null
        ? isRequired
              ? Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    // color: AppColors.grey,
                  ),
                )
              : Text(label)
        : null,
    labelStyle: const TextStyle(color: AppColors.grey),
    errorStyle: const TextStyle(color: AppColors.error, fontSize: 12),
  );
}

InputDecoration dropDownHintDecoration(String? hint) {
  return InputDecoration(
    border: AppOutlineInputBorder(
      color: AppColors.grey.withValues(alpha: .30),
      isReadOnly: false,
    ),
    focusedBorder: AppOutlineInputBorder(
      color: AppColors.grey.withValues(alpha: .30),
      isReadOnly: false,
    ),
    enabledBorder: AppOutlineInputBorder(
      color: AppColors.grey.withValues(alpha: .30),
      isReadOnly: false,
    ),
    contentPadding: const EdgeInsetsDirectional.only(
      start: 15.0,
      end: 0,
      bottom: 4.5,
    ),
    fillColor: AppColors.fourth,
    filled: true,
    hintStyle: const TextStyle(color: AppColors.grey),
    errorStyle: const TextStyle(color: AppColors.error, fontSize: 12),
    hintText: hint,
  );
}
