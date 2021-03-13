part of "shared.dart";

// SECTION[epic=Text Styles]

const TextStyle kMainStyle = TextStyle(fontFamily: "NotoSansKR");

TextStyle kOnBoardingTitleStyle = kMainStyle.copyWith(
  color: AppColor.STAccent,
  fontSize: kTitleTextSize,
  fontWeight: FontWeightX.black,
  letterSpacing: 2,
);

TextStyle kTitleStyle = kMainStyle.copyWith(
  color: AppColor.STGrey,
  fontSize: kTitleTextSize,
  fontWeight: FontWeightX.bold,
  letterSpacing: 2,
);

TextStyle kHeader2Style = kMainStyle.copyWith(
  fontSize: kHeader2TextSize,
  fontWeight: FontWeightX.bold,
  letterSpacing: -2,
);

TextStyle kHeader3Style = kMainStyle.copyWith(
  fontSize: kHeader3TextSize,
  fontWeight: FontWeightX.bold,
);

TextStyle kBodyLargeStyle = kMainStyle.copyWith(
  fontSize: kBodyLargeTextSize,
  fontWeight: FontWeightX.medium,
);

TextStyle kBodyStyle = kMainStyle.copyWith(
  fontSize: kBodyTextSize,
  fontWeight: FontWeightX.regular,
);

TextStyle kBodyBoldStyle = kMainStyle.copyWith(
  fontSize: kBodyTextSize,
  // fontFamily: "NotoSansKR",
  fontWeight: FontWeightX.bold,
);

TextStyle kMediumStyle = kMainStyle.copyWith(
  fontSize: kMeduimTextSize,
  fontWeight: FontWeightX.medium,
);

TextStyle kSmallStyle = kMainStyle.copyWith(
  fontSize: kSmallTextSize,
  fontWeight: FontWeightX.medium,
);

TextStyle kPreTitleStyle = kMainStyle.copyWith(
  fontSize: kPreTitleTextSize,
  fontWeight: FontWeightX.bold,
  // letterSpacing: -1,
);

TextStyle kNavigationStyle = kMainStyle.copyWith(
  fontSize: kNavigationBarTextSize,
  fontWeight: FontWeightX.bold,
);

TextStyle kLinkStyle = kMainStyle.copyWith(
  fontSize: kBodyTextSize,
  fontWeight: FontWeightX.bold,
  color: AppColor.STSkyBlue,
  decoration: TextDecoration.underline,
);

// !SECTION

// SECTION[epic=Text Size]
/// 16
const double kBodyTextSize = 16;

/// 35
const double kTitleTextSize = 35;

/// 30
const double kHeader2TextSize = 30;

/// 20
const double kHeader3TextSize = 20;

/// 18
const double kBodyLargeTextSize = 18;

/// 14
const double kMeduimTextSize = 14;

/// 12
const double kSmallTextSize = 12;

/// 10
const double kPreTitleTextSize = 10;

/// 17
const double kNavigationBarTextSize = 17;

// !SECTION

// SECTION[epic=Card Shapes]

ShapeBorder kRoundedCardBorder({double radius = 12}) => RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    );


// !SECTION