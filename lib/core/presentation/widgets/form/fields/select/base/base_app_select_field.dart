import 'package:flutter/material.dart';

import '../../../app_form_field.dart';
import '../data_source/app_select_data_source.dart';
import '../display/app_select_display_strategy.dart';
import '../popup/app_select_popup_strategy.dart';
import 'app_select_typedefs.dart';

/// Abstract base class for all select fields with form binding logic.
///
/// Provides the foundation for single and multi-select fields, handling form
/// integration, state management, and template method pattern for display
/// and popup strategies.
///
/// Architecture: 4-layer system (Base, Data Source, Display Strategy, Popup Strategy)
///
/// Generic parameters:
/// - [TValue]: FormControl value type (T? for single, List`<`T`>` for multi)
/// - [TItem]: Type of individual item in the selection list
abstract class BaseAppSelectField<TValue, TItem>
    extends AppFormField<TValue, TValue> {
  BaseAppSelectField({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.showErrors,
    super.focusNode,
    required this.itemIdentity,
    required this.dataSource,
    required this.displayStrategy,
    this.popupStrategy,
  }) : super(
         builder: (field) {
           final state = field as BaseAppSelectFieldState<TValue, TItem>;
           return state.buildFieldDisplay();
         },
       );

  /// Function to get unique identity of item for comparison.
  ///
  /// Returns a unique identifier for each item (typically an ID or primary key).
  /// Used to determine if an item is selected and to compare items for equality.
  final AppItemIdentity<TItem> itemIdentity;

  /// Data source for loading items (Layer 2).
  ///
  /// Provides items to display in the popup. Use [AppSelectFixedDataSource]
  /// for fixed lists or [AppSelectPaginatedDataSource] for paginated API data.
  final AppSelectDataSource<TItem> dataSource;

  /// Display strategy for rendering selected value(s) in field (Layer 3).
  ///
  /// Defines how the selected value(s) are displayed in the field UI.
  /// Use [AppSelectTextFieldDisplay] for default text field display.
  final AppSelectDisplayStrategy<TValue, TItem> displayStrategy;

  /// Popup strategy for showing selection UI (Layer 4).
  ///
  /// Defines how the selection popup is displayed. Use [AppSelectBottomSheetPopup],
  /// [AppMultiSelectBottomSheetPopup], or [AppSelectDropdownPopup].
  ///
  /// Optional: some displays (như chip inline) có thể không cần popup.
  final AppSelectPopupStrategy<TValue, TItem>? popupStrategy;

  @override
  BaseAppSelectFieldState<TValue, TItem> createState();
}

/// Abstract state class with template method pattern and form binding logic.
///
/// Provides state management for select fields with template methods that
/// concrete implementations must override: [buildFieldDisplay()] and
/// [showSelectionPopup()].
abstract class BaseAppSelectFieldState<TValue, TItem>
    extends AppFormFieldState<TValue, TValue> {
  @override
  BaseAppSelectField<TValue, TItem> get widget =>
      super.widget as BaseAppSelectField<TValue, TItem>;

  /// Flag to prevent duplicate taps
  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();
    // Preload items for page 1 to optimize popup opening
    preloadItems();
  }

  /// Preload items asynchronously from the data source.
  ///
  /// Called automatically in [initState()] to optimize popup opening speed.
  /// Override [onCachedItemsLoaded] to perform actions when items are loaded.
  @protected
  void preloadItems() {
    widget.dataSource.preload().then(onCachedItemsLoaded);
  }

  /// Callback invoked when cached items are loaded.
  ///
  /// Override this method to perform actions when items are preloaded.
  void onCachedItemsLoaded(AppSelectDataPage<TItem> page) {
    // Do something with the cached items
  }

  /// Template method: Build UI to display the field.
  ///
  /// Concrete classes must override to delegate to the display strategy.
  Widget buildFieldDisplay();

  /// Template method: Show popup and return selected value.
  ///
  /// Concrete classes must override to delegate to the popup strategy.
  /// Returns the selected value or `null` if cancelled.
  Future<TValue?>? showSelectionPopup();

  /// Handle tap on the field.
  ///
  /// Shows popup, updates value if changed, and marks field as touched.
  Future<void> handleFieldTap() async {
    // Check if already selecting
    if (_isSelecting) return;

    // Check if disabled
    if (!control.enabled) return;

    _isSelecting = true;

    try {
      // Call template method to show popup
      final result = await showSelectionPopup();

      // Update value if changed
      if (result != null && result != value) {
        didChange(result);
      }
    } finally {
      control.unfocus();
      control.markAsTouched();
      _isSelecting = false;
    }
  }
}
