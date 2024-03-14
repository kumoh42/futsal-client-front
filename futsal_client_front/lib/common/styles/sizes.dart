import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

const double kWLayoutMaxSize = 1440;
const double kWLayoutMarginSize = 36.0;
const double kWLayoutGutterSize = 12.0;

const double kMobileTrigger = 768;

const double kMLayoutMaxSize = 400;
const double kMLayoutMarginSize = 12.0;
const double kMLayoutGutterSize = 10.0;

double get kLayoutMaxSize =>
    ResponsiveData.kIsMobile ? kMLayoutMaxSize : kWLayoutMaxSize;

double get kLayoutMarginSize =>
    ResponsiveData.kIsMobile ? kMLayoutMarginSize : kWLayoutMarginSize;

double get kLayoutGutterSize =>
    ResponsiveData.kIsMobile ? kMLayoutGutterSize : kWLayoutGutterSize;

abstract class ResponsiveData {
  static bool kIsMobile = false;
  static const double _kMWRatio = 0.5;
  static const double _kWMRatio2 = 6.0;
}

abstract class ResponsiveSize {
  static double W(double size) => min(size, size.sp);

  static double M(double size) => min(
        size * ResponsiveData._kMWRatio,
        (size * ResponsiveData._kMWRatio * ResponsiveData._kWMRatio2).sp,
      );

  static double S(double size) => ResponsiveData.kIsMobile ? M(size) : W(size);
}

const double kWTextTitleSize = 30.0;
const double kWTextLargeSize = 28.0;
const double kWTextMiddleSize = 21.0;
const double kWTextSmallSize = 18.0;
const double kWTextMiniSize = 14.0;
const double kWTextSuperMiniSize = 10.0;

double get kTextTitleSize => ResponsiveSize.S(kWTextTitleSize);

double get kTextLargeSize => ResponsiveSize.S(kWTextLargeSize);

double get kTextMiddleSize => ResponsiveSize.S(kWTextMiddleSize);

double get kTextSmallSize => ResponsiveSize.S(kWTextSmallSize);

double get kTextMiniSize => ResponsiveSize.S(kWTextMiniSize);

double get kTextSuperMiniSize => ResponsiveSize.S(kWTextSuperMiniSize);

const double kWPaddingXLargeSize = 32.0;
const double kWPaddingLargeSize = 16.0;
const double kWPaddingMiddleSize = 12.0;
const double kWPaddingSmallSize = 8.0;
const double kWPaddingMiniSize = 4.0;

double get kPaddingXLargeSize => ResponsiveSize.S(kWPaddingXLargeSize);

double get kPaddingLargeSize => ResponsiveSize.S(kWPaddingLargeSize);

double get kPaddingMiddleSize => ResponsiveSize.S(kWPaddingMiddleSize);

double get kPaddingSmallSize => ResponsiveSize.S(kWPaddingSmallSize);

double get kPaddingMiniSize => ResponsiveSize.S(kWPaddingMiniSize);

const double kWIconLargeSize = 41.0;
const double kWIconMiddleSize = 28.0;
const double kWIconSmallSize = 20.0;
const double kWIconMiniSize = 16.0;

double get kIconLargeSize => ResponsiveSize.S(kWIconLargeSize);

double get kIconMiddleSize => ResponsiveSize.S(kWIconMiddleSize);

double get kIconSmallSize => ResponsiveSize.S(kWIconSmallSize);

double get kIconMiniSize => ResponsiveSize.S(kWIconMiniSize);

const double kWBorderRadiusSize = 10.0;
const double kMBorderRadiusSize = 5.0;

double get kBorderRadiusSize =>
    ResponsiveData.kIsMobile ? kMBorderRadiusSize : kWBorderRadiusSize;

const double kWBorderWidth = 5.0;

double get kBorderWidth => ResponsiveSize.S(kWBorderWidth);