import 'package:flutter/material.dart';

abstract final class AppShadows {
  static const xs = [
    BoxShadow(
      color: Color(0x0D0A0D12),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static const sm = [
    BoxShadow(
      color: Color(0x1A0A0D12),
      offset: Offset(0, 1),
      blurRadius: 3,
    ),
    BoxShadow(
      color: Color(0x0F0A0D12),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static const md = [
    BoxShadow(
      color: Color(0x1A0A0D12),
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: -2,
    ),
    BoxShadow(
      color: Color(0x0F0A0D12),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
    ),
  ];

  static const lg = [
    BoxShadow(
      color: Color(0x140A0D12),
      offset: Offset(0, 12),
      blurRadius: 16,
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Color(0x080A0D12),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];

  static const xl = [
    BoxShadow(
      color: Color(0x140A0D12),
      offset: Offset(0, 20),
      blurRadius: 24,
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Color(0x080A0D12),
      offset: Offset(0, 8),
      blurRadius: 8,
      spreadRadius: -4,
    ),
  ];

  static const xxl = [
    BoxShadow(
      color: Color(0x2E0A0D12),
      offset: Offset(0, 24),
      blurRadius: 48,
      spreadRadius: -12,
    ),
  ];

  static const xxxl = [
    BoxShadow(
      color: Color(0x240A0D12),
      offset: Offset(0, 32),
      blurRadius: 64,
      spreadRadius: -12,
    ),
  ];
}

class AppShadowToken {
  const AppShadowToken({
    required this.name,
    required this.codeName,
    required this.value,
    required this.shadows,
  });

  final String name;
  final String codeName;
  final String value;
  final List<BoxShadow> shadows;
}

const appShadowTokens = [
  AppShadowToken(
    name: 'xs',
    codeName: 'AppShadows.xs',
    value: '0px 1px 2px rgba(10, 13, 18, 0.05)',
    shadows: AppShadows.xs,
  ),
  AppShadowToken(
    name: 'sm',
    codeName: 'AppShadows.sm',
    value:
        '0px 1px 3px rgba(10, 13, 18, 0.10), 0px 1px 2px rgba(10, 13, 18, 0.06)',
    shadows: AppShadows.sm,
  ),
  AppShadowToken(
    name: 'md',
    codeName: 'AppShadows.md',
    value:
        '0px 4px 8px -2px rgba(10, 13, 18, 0.10), 0px 2px 4px -2px rgba(10, 13, 18, 0.06)',
    shadows: AppShadows.md,
  ),
  AppShadowToken(
    name: 'lg',
    codeName: 'AppShadows.lg',
    value:
        '0px 12px 16px -4px rgba(10, 13, 18, 0.08), 0px 4px 6px -2px rgba(10, 13, 18, 0.03)',
    shadows: AppShadows.lg,
  ),
  AppShadowToken(
    name: 'xl',
    codeName: 'AppShadows.xl',
    value:
        '0px 20px 24px -4px rgba(10, 13, 18, 0.08), 0px 8px 8px -4px rgba(10, 13, 18, 0.03)',
    shadows: AppShadows.xl,
  ),
  AppShadowToken(
    name: '2xl',
    codeName: 'AppShadows.xxl',
    value: '0px 24px 48px -12px rgba(10, 13, 18, 0.18)',
    shadows: AppShadows.xxl,
  ),
  AppShadowToken(
    name: '3xl',
    codeName: 'AppShadows.xxxl',
    value: '0px 32px 64px -12px rgba(10, 13, 18, 0.14)',
    shadows: AppShadows.xxxl,
  ),
];
