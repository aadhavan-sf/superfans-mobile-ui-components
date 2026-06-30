import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/app_radius.dart';
import '../../foundation/app_spacing.dart';
import '../../foundation/app_typography.dart';

/// Mobile toolbar — Flutter port of Dashboard
/// `src/components/mobile-ui/Toolbar/Toolbar.tsx`.
enum SfToolbarVariant {
  homepage1('Homepage 1'),
  homepage2('Homepage 2');

  const SfToolbarVariant(this.label);

  final String label;
}

enum SfToolbarLeftAction {
  back('Back'),
  notifications('Notifications'),
  menu('Menu'),
  none('None');

  const SfToolbarLeftAction(this.label);

  final String label;
}

enum SfToolbarCenterContent {
  textLabel('Label'),
  mark('Mark'),
  logo('Logo');

  const SfToolbarCenterContent(this.label);

  final String label;
}

enum SfToolbarRightAction {
  search('Search'),
  notifications('Notifications'),
  notificationsBadge('Notifications badge'),
  wishlist('Wishlist'),
  cart('Cart'),
  cartBadge('Cart badge'),
  account('Account'),
  none('None');

  const SfToolbarRightAction(this.label);

  final String label;

  bool get hasBadge =>
      this == SfToolbarRightAction.notificationsBadge ||
      this == SfToolbarRightAction.cartBadge;
}

const sfToolbarRightIconSlotOptions = [
  SfToolbarRightAction.search,
  SfToolbarRightAction.notifications,
  SfToolbarRightAction.notificationsBadge,
  SfToolbarRightAction.wishlist,
  SfToolbarRightAction.cart,
  SfToolbarRightAction.cartBadge,
  SfToolbarRightAction.account,
];

/// Label tracking 0.2em at 14px — not on the type scale.
const _toolbarLabelLetterSpacing = 2.8;

abstract final class _SfToolbarMetrics {
  static const iconSize = AppSpacing.spacing6;
  static const iconPadding = AppSpacing.spacing2;
  static const horizontalPadding = AppSpacing.spacing4;
  static const leftSectionMinWidth = AppSpacing.spacing10;

  /// Figma frame width — not on the size scale.
  static const shellWidth = 375.0;

  /// Max shell width — not on the size scale.
  static const shellMaxWidth = 430.0;

  /// Figma toolbar height (60px) — not on the size scale.
  static const toolbarHeight = 60.0;

  /// Mark logo width (26px) — not on the size scale.
  static const markWidth = 26.0;

  /// Full logo max width (151px) — not on the size scale.
  static const logoMaxWidth = 151.0;

  /// Center preview width (167px) — not on the size scale.
  static const centerPreviewWidth = 167.0;

  /// Badge text at 8px — not on the type scale.
  static const badgeFontSizeWide = 8.0;

  /// Badge text at 9px — not on the type scale.
  static const badgeFontSizeNarrow = 9.0;

  /// Badge size for two-digit counts (18px) — not on the size scale.
  static const badgeSizeWide = 18.0;
}

class SfToolbar extends StatelessWidget {
  const SfToolbar({
    super.key,
    this.variant,
    this.leftAction,
    this.centerContent,
    this.centerLabel = 'LABEL',
    this.rightIconSlot1,
    this.rightIconSlot2,
    this.badgeCount,
    this.onBack,
    this.onMenu,
    this.onSearch,
    this.onNotifications,
    this.onWishlist,
    this.onCart,
    this.onAccount,
  });

  final SfToolbarVariant? variant;
  final SfToolbarLeftAction? leftAction;
  final SfToolbarCenterContent? centerContent;
  final String centerLabel;
  final SfToolbarRightAction? rightIconSlot1;
  final SfToolbarRightAction? rightIconSlot2;
  final int? badgeCount;
  final VoidCallback? onBack;
  final VoidCallback? onMenu;
  final VoidCallback? onSearch;
  final VoidCallback? onNotifications;
  final VoidCallback? onWishlist;
  final VoidCallback? onCart;
  final VoidCallback? onAccount;

  static const shellWidth = _SfToolbarMetrics.shellWidth;
  static const shellMaxWidth = _SfToolbarMetrics.shellMaxWidth;
  static const toolbarHeight = _SfToolbarMetrics.toolbarHeight;
  static const markWidth = _SfToolbarMetrics.markWidth;
  static const logoMaxWidth = _SfToolbarMetrics.logoMaxWidth;

  static const _logoAsset = 'assets/images/superfans-logo-white.png';
  static const _markAsset = 'assets/images/superfans-mark.png';

  _ResolvedToolbar _resolve() {
    final preset = variant == null ? null : _variantPresets[variant!]!;

    final resolvedLeftAction =
        leftAction ?? preset?.leftAction ?? SfToolbarLeftAction.none;
    final resolvedCenterContent =
        centerContent ?? preset?.centerContent ?? SfToolbarCenterContent.logo;
    final resolvedRightActions = _resolveRightActions(preset: preset);
    final resolvedBadgeCount = badgeCount ?? preset?.badgeCount ?? 10;
    final logoPlacement = preset?.logoPlacement ??
        (resolvedLeftAction == SfToolbarLeftAction.none &&
                resolvedCenterContent != SfToolbarCenterContent.textLabel
            ? _ToolbarLogoPlacement.left
            : _ToolbarLogoPlacement.center);

    return _ResolvedToolbar(
      leftAction: resolvedLeftAction,
      centerContent: resolvedCenterContent,
      centerLabel: centerLabel,
      logoPlacement: logoPlacement,
      rightActions: resolvedRightActions,
      badgeCount: resolvedBadgeCount,
    );
  }

  List<SfToolbarRightAction> _resolveRightActions({
    _ToolbarVariantPreset? preset,
  }) {
    final presetActions =
        preset?.rightActions ?? const [SfToolbarRightAction.search, SfToolbarRightAction.cartBadge];
    final hasSlotProps =
        rightIconSlot1 != null || rightIconSlot2 != null;

    if (hasSlotProps) {
      var slot1 = rightIconSlot1 ?? presetActions.first;
      var slot2 = rightIconSlot2 ?? presetActions[1];

      if (slot1 == slot2) {
        slot2 = sfToolbarRightIconSlotOptions.firstWhere(
          (action) => action != slot1,
          orElse: () => SfToolbarRightAction.cartBadge,
        );
      }

      return [slot1, slot2];
    }

    return presetActions;
  }

  @override
  Widget build(BuildContext context) {
    final resolved = _resolve();

    return Semantics(
      header: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: shellMaxWidth,
          minWidth: shellWidth,
        ),
        child: SizedBox(
          width: shellWidth,
          height: toolbarHeight,
          child: ColoredBox(
            color: AppColors.neutral900,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (resolved.logoPlacement == _ToolbarLogoPlacement.center)
                  IgnorePointer(
                    child: _ToolbarBrand(
                      centerContent: resolved.centerContent,
                      centerLabel: resolved.centerLabel,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: _SfToolbarMetrics.horizontalPadding,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: _SfToolbarMetrics.leftSectionMinWidth,
                          ),
                          child: Row(
                            children: [
                              _ToolbarLeftControl(
                                action: resolved.leftAction,
                                onBack: onBack,
                                onMenu: onMenu,
                                onNotifications: onNotifications,
                              ),
                              if (resolved.logoPlacement ==
                                  _ToolbarLogoPlacement.left)
                                _ToolbarBrand(
                                  centerContent: resolved.centerContent,
                                  centerLabel: resolved.centerLabel,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (var index = 0;
                              index < resolved.rightActions.length;
                              index++)
                            _ToolbarRightControl(
                              key: ValueKey(
                                '${resolved.rightActions[index]}-$index',
                              ),
                              action: resolved.rightActions[index],
                              badgeCount: resolved.badgeCount,
                              onSearch: onSearch,
                              onNotifications: onNotifications,
                              onWishlist: onWishlist,
                              onCart: onCart,
                              onAccount: onAccount,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _ToolbarLogoPlacement { left, center }

class _ToolbarVariantPreset {
  const _ToolbarVariantPreset({
    required this.leftAction,
    required this.centerContent,
    required this.logoPlacement,
    required this.rightActions,
    required this.badgeCount,
  });

  final SfToolbarLeftAction leftAction;
  final SfToolbarCenterContent centerContent;
  final _ToolbarLogoPlacement logoPlacement;
  final List<SfToolbarRightAction> rightActions;
  final int badgeCount;
}

const _variantPresets = {
  SfToolbarVariant.homepage1: _ToolbarVariantPreset(
    leftAction: SfToolbarLeftAction.back,
    centerContent: SfToolbarCenterContent.logo,
    logoPlacement: _ToolbarLogoPlacement.center,
    rightActions: [SfToolbarRightAction.search, SfToolbarRightAction.cartBadge],
    badgeCount: 10,
  ),
  SfToolbarVariant.homepage2: _ToolbarVariantPreset(
    leftAction: SfToolbarLeftAction.none,
    centerContent: SfToolbarCenterContent.logo,
    logoPlacement: _ToolbarLogoPlacement.left,
    rightActions: [SfToolbarRightAction.search, SfToolbarRightAction.cartBadge],
    badgeCount: 10,
  ),
};

class _ResolvedToolbar {
  const _ResolvedToolbar({
    required this.leftAction,
    required this.centerContent,
    required this.centerLabel,
    required this.logoPlacement,
    required this.rightActions,
    required this.badgeCount,
  });

  final SfToolbarLeftAction leftAction;
  final SfToolbarCenterContent centerContent;
  final String centerLabel;
  final _ToolbarLogoPlacement logoPlacement;
  final List<SfToolbarRightAction> rightActions;
  final int badgeCount;
}

class _ToolbarBrand extends StatelessWidget {
  const _ToolbarBrand({
    required this.centerContent,
    required this.centerLabel,
  });

  final SfToolbarCenterContent centerContent;
  final String centerLabel;

  @override
  Widget build(BuildContext context) {
    return switch (centerContent) {
      SfToolbarCenterContent.textLabel => Text(
        centerLabel.toUpperCase(),
        style: AppTypography.textSm
            .semibold(color: AppColors.neutral00)
            .copyWith(letterSpacing: _toolbarLabelLetterSpacing),
      ),
      SfToolbarCenterContent.mark => Image.asset(
        SfToolbar._markAsset,
        height: _SfToolbarMetrics.iconSize,
        width: SfToolbar.markWidth,
        fit: BoxFit.contain,
        semanticLabel: 'Superfans',
      ),
      SfToolbarCenterContent.logo => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: SfToolbar.logoMaxWidth),
        child: Image.asset(
          SfToolbar._logoAsset,
          height: _SfToolbarMetrics.iconSize,
          fit: BoxFit.contain,
          semanticLabel: 'Superfans',
          filterQuality: FilterQuality.high,
        ),
      ),
    };
  }
}

class _ToolbarLeftControl extends StatelessWidget {
  const _ToolbarLeftControl({
    required this.action,
    this.iconColor = AppColors.neutral00,
    this.onBack,
    this.onMenu,
    this.onNotifications,
  });

  final SfToolbarLeftAction action;
  final Color iconColor;
  final VoidCallback? onBack;
  final VoidCallback? onMenu;
  final VoidCallback? onNotifications;

  @override
  Widget build(BuildContext context) {
    return switch (action) {
      SfToolbarLeftAction.none => const SizedBox.shrink(),
      SfToolbarLeftAction.back => _ToolbarIconButton(
        semanticLabel: 'Go back',
        onTap: onBack,
        icon: PhosphorIconsRegular.caretLeft,
        iconColor: iconColor,
      ),
      SfToolbarLeftAction.notifications => _ToolbarIconButton(
        semanticLabel: 'Notifications',
        onTap: onNotifications,
        icon: PhosphorIconsRegular.bell,
        iconColor: iconColor,
      ),
      SfToolbarLeftAction.menu => _ToolbarIconButton(
        semanticLabel: 'Open menu',
        onTap: onMenu,
        icon: PhosphorIconsRegular.list,
        iconColor: iconColor,
      ),
    };
  }
}

class _ToolbarRightControl extends StatelessWidget {
  const _ToolbarRightControl({
    super.key,
    required this.action,
    required this.badgeCount,
    this.iconColor = AppColors.neutral00,
    this.onSearch,
    this.onNotifications,
    this.onWishlist,
    this.onCart,
    this.onAccount,
  });

  final SfToolbarRightAction action;
  final int badgeCount;
  final Color iconColor;
  final VoidCallback? onSearch;
  final VoidCallback? onNotifications;
  final VoidCallback? onWishlist;
  final VoidCallback? onCart;
  final VoidCallback? onAccount;

  @override
  Widget build(BuildContext context) {
    if (action == SfToolbarRightAction.none) {
      return const _ToolbarIconPlaceholder();
    }

    final showBadge = action.hasBadge;

    return _ToolbarIconButton(
      semanticLabel: action.label,
      badgeCount: showBadge ? badgeCount : null,
      iconColor: iconColor,
      onTap: switch (action) {
        SfToolbarRightAction.search => onSearch,
        SfToolbarRightAction.notifications ||
        SfToolbarRightAction.notificationsBadge =>
          onNotifications,
        SfToolbarRightAction.wishlist => onWishlist,
        SfToolbarRightAction.cart || SfToolbarRightAction.cartBadge => onCart,
        SfToolbarRightAction.account => onAccount,
        SfToolbarRightAction.none => null,
      },
      icon: switch (action) {
        SfToolbarRightAction.search => PhosphorIconsRegular.magnifyingGlass,
        SfToolbarRightAction.notifications ||
        SfToolbarRightAction.notificationsBadge =>
          PhosphorIconsRegular.bell,
        SfToolbarRightAction.wishlist => PhosphorIconsRegular.heart,
        SfToolbarRightAction.cart || SfToolbarRightAction.cartBadge =>
          PhosphorIconsRegular.shoppingCart,
        SfToolbarRightAction.account => PhosphorIconsRegular.user,
        SfToolbarRightAction.none => PhosphorIconsRegular.magnifyingGlass,
      },
    );
  }
}

class _ToolbarIconPlaceholder extends StatelessWidget {
  const _ToolbarIconPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_SfToolbarMetrics.iconPadding),
      child: SizedBox(
        width: _SfToolbarMetrics.iconSize,
        height: _SfToolbarMetrics.iconSize,
      ),
    );
  }
}

class _ToolbarIconButton extends StatefulWidget {
  const _ToolbarIconButton({
    required this.semanticLabel,
    required this.icon,
    this.iconColor = AppColors.neutral00,
    this.badgeCount,
    this.onTap,
  });

  final String semanticLabel;
  final IconData icon;
  final Color iconColor;
  final int? badgeCount;
  final VoidCallback? onTap;

  @override
  State<_ToolbarIconButton> createState() => _ToolbarIconButtonState();
}

class _ToolbarIconButtonState extends State<_ToolbarIconButton> {
  bool _focused = false;

  static const _focusBrandShadow = [
    BoxShadow(
      color: AppColors.brand100,
      spreadRadius: AppSpacing.spacing1,
    ),
  ];

  String _formatBadgeCount(int count) {
    return count > 99 ? '99+' : '$count';
  }

  TextStyle _badgeTextStyle(bool isWideBadge) {
    return AppTypography.textXs
        .semibold(color: AppColors.neutral00)
        .copyWith(
          fontSize: isWideBadge
              ? _SfToolbarMetrics.badgeFontSizeWide
              : _SfToolbarMetrics.badgeFontSizeNarrow,
          height: 1,
        );
  }

  @override
  Widget build(BuildContext context) {
    final badgeText = widget.badgeCount == null
        ? null
        : _formatBadgeCount(widget.badgeCount!);
    final isWideBadge = badgeText != null && badgeText.length > 1;

    return Semantics(
      button: true,
      label: widget.semanticLabel,
      child: Focus(
        onFocusChange: (focused) => setState(() => _focused = focused),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: widget.onTap,
            customBorder: const CircleBorder(),
            splashColor: AppColors.neutral100.withValues(alpha: 0.2),
            highlightColor: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                boxShadow: _focused ? _focusBrandShadow : null,
                borderRadius: BorderRadius.circular(AppRadius.radius2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(_SfToolbarMetrics.iconPadding),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    PhosphorIcon(
                      widget.icon,
                      size: _SfToolbarMetrics.iconSize,
                      color: widget.iconColor,
                    ),
                    if (badgeText != null && widget.badgeCount! > 0)
                      Positioned(
                        right: -AppSpacing.spacing1,
                        top: -AppSpacing.spacing1,
                        child: Container(
                          width: isWideBadge
                              ? _SfToolbarMetrics.badgeSizeWide
                              : AppSpacing.spacing4,
                          height: isWideBadge
                              ? _SfToolbarMetrics.badgeSizeWide
                              : AppSpacing.spacing4,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.error500,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            badgeText,
                            style: _badgeTextStyle(isWideBadge),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Playground knob for left action — `fromVariant` keeps the Figma preset.
enum SfToolbarLeftActionKnob {
  fromVariant('From variant'),
  back('Back'),
  notifications('Notifications'),
  menu('Menu'),
  none('None');

  const SfToolbarLeftActionKnob(this.label);

  final String label;

  SfToolbarLeftAction? get action => switch (this) {
    SfToolbarLeftActionKnob.fromVariant => null,
    SfToolbarLeftActionKnob.back => SfToolbarLeftAction.back,
    SfToolbarLeftActionKnob.notifications => SfToolbarLeftAction.notifications,
    SfToolbarLeftActionKnob.menu => SfToolbarLeftAction.menu,
    SfToolbarLeftActionKnob.none => SfToolbarLeftAction.none,
  };
}

/// Playground knob for center content — `fromVariant` keeps the Figma preset.
enum SfToolbarCenterContentKnob {
  fromVariant('From variant'),
  textLabel('Label'),
  mark('Mark'),
  logo('Logo');

  const SfToolbarCenterContentKnob(this.label);

  final String label;

  SfToolbarCenterContent? get content => switch (this) {
    SfToolbarCenterContentKnob.fromVariant => null,
    SfToolbarCenterContentKnob.textLabel => SfToolbarCenterContent.textLabel,
    SfToolbarCenterContentKnob.mark => SfToolbarCenterContent.mark,
    SfToolbarCenterContentKnob.logo => SfToolbarCenterContent.logo,
  };
}

/// Preview wrapper for left-slot options in Widgetbook variants.
class SfToolbarLeftActionPreview extends StatelessWidget {
  const SfToolbarLeftActionPreview({super.key, required this.action});

  final SfToolbarLeftAction action;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(AppRadius.radius2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacing2),
        child: action == SfToolbarLeftAction.none
            ? const _ToolbarIconPlaceholder()
            : _ToolbarLeftControl(
                action: action,
                iconColor: AppColors.neutral800,
              ),
      ),
    );
  }
}

/// Preview wrapper for center-slot options in Widgetbook variants.
class SfToolbarCenterContentPreview extends StatelessWidget {
  const SfToolbarCenterContentPreview({
    super.key,
    required this.centerContent,
    this.centerLabel = 'LABEL',
  });

  final SfToolbarCenterContent centerContent;
  final String centerLabel;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.neutral900,
        borderRadius: BorderRadius.circular(AppRadius.radius2),
      ),
      child: SizedBox(
        height: SfToolbar.toolbarHeight,
        width: _SfToolbarMetrics.centerPreviewWidth,
        child: Center(
          child: _ToolbarBrand(
            centerContent: centerContent,
            centerLabel: centerLabel,
          ),
        ),
      ),
    );
  }
}

/// Preview wrapper for right-slot options in Widgetbook variants.
class SfToolbarRightActionPreview extends StatelessWidget {
  const SfToolbarRightActionPreview({
    super.key,
    required this.action,
    this.badgeCount = 10,
  });

  final SfToolbarRightAction action;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        borderRadius: BorderRadius.circular(AppRadius.radius2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacing2),
        child: _ToolbarRightControl(
          action: action,
          badgeCount: badgeCount,
          iconColor: AppColors.neutral800,
        ),
      ),
    );
  }
}
