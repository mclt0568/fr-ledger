import 'dart:ui';

import 'package:flutter/widgets.dart';

// Effects
const BoxShadow slightElevated = BoxShadow(
    offset: Offset(0, 1.5),
    blurRadius: 2,
    spreadRadius: 1,
    color: Color(0x88c5c5c5));

const BoxShadow slightElevatedOverOverlay = BoxShadow(
    offset: Offset(0, 1.5),
    blurRadius: 10,
    spreadRadius: 1,
    color: Color(0x88c5c5c5));

ImageFilter overlayBlurFilter = ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5);

// Colors
const Color headerColor = Color(0xFF000000);
const Color paragraphColorDark = Color(0xFF5B5B5B);
const Color paragraphColorLight = Color(0xFF868686);
const Color accent = Color(0xFF00826A);
const Color accentLighter = Color(0xFFC2F2EA);
const Color accentDarker = Color(0xFF006351);
const Color grayBackground = Color(0xFFF3F3F3);
const Color gray = Color(0xFFD9D9D9);
const Color secondaryAccentBackground = Color(0xFFE8C960);
const Color white = Color(0xFFFFFFFF);

const Color accentFocus = Color(0xFFE2FFFA);

const Color disabledBackground = Color(0xFFECECEC);
const Color disabledForeground = Color(0xFF898989);

const Color greenBackground = Color(0xFFE0FFE9);
const Color greenForeground = Color(0xFF198038);

const Color yellowBackground = Color(0xFFFFEFB9);
const Color yellowForeground = Color(0xFF9C7900);

const Color orangeBackground = Color(0xFFFFECDE);
const Color orangeForeground = Color(0xFFDD5C00);

const Color error = Color(0xFFD12831);
const Color errorBackground = Color(0xFFFFDBDD);
const Color errorDisabled = Color(0xFFAA898A);

const Color transparent = Color(0x00000000);
const Color overlayTransparent = Color.fromARGB(100, 151, 151, 151);

// Dimensions
const double appbarPadding = 20;
const double appbarHeight = 60;
const double appbarButtonPadding = 3;

const double standardIconSize = 23;

const double pagePadding = 25;
const double headerPadding = 20;

const double ledgerEntryCardHeight = 65;
const double ledgerEntryCardPadding = 3;
const double ledgerEntryCardPrograssHeight = 5;
const double ledgerEntryCardMarginBottom = 15;

const double settingsGroupElementPaddingVertical = 15;
const double settingsButtonHeight = 55;

// Font sizes
const double headerFontSize = 20;
const double subheaderFontSize = 14;
const double defaultParagraphFontSize = 14;
