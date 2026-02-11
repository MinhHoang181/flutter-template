part of '../app_select_bottom_sheet.dart';

class _AppSelectBottomSheetItem<T> extends StatelessWidget {
  const _AppSelectBottomSheetItem({
    super.key,
    required this.item,
    required this.display,
    required this.selected,
    required this.onTap,
    required this.minTileHeight,
    this.leadingBuilder,
    this.trailingBuilder,
  });

  final T item;

  final double minTileHeight;

  final bool selected;

  final String Function(T item) display;

  final AppSelectBottomSheetItemLeadingBuilder<T>? leadingBuilder;

  final AppSelectBottomSheetItemTrailingBuilder<T>? trailingBuilder;

  final AppSelectBottomSheetItemOnTap<T> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: minTileHeight,
        child: ListTile(
          tileColor: Theme.of(context).colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4,
            vertical: 0,
          ),
          leading: leadingBuilder?.call(item, selected),
          title: AppText(
            display(item),
            style: AppFonts.size14Medium.copyWith(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
            maxLines: null,
          ),
          trailing:
              trailingBuilder?.call(item, selected) ??
              (selected
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null),
          onTap: () => onTap(item, selected),
        ),
      ),
    );
  }
}
