part of "shared.dart";

// SECTION[epic=Horizontal Spacing]
/// 5
const Widget horizontalSpaceTiny = SizedBox(width: 5.0);

/// 10
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);

/// 18
const Widget horizontalSpaceRegular = SizedBox(width: 18.0);

/// 25
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);

///50
const Widget horizontalSpaceLarge = SizedBox(width: 50.0);

// !SECTION

// SECTION[epic=Vertical Spacing]
/// 5
const Widget verticalSpaceTiny = SizedBox(height: 5.0);

/// 10
const Widget verticalSpaceSmall = SizedBox(height: 10.0);

/// 18
const Widget verticalSpaceRegular = SizedBox(height: 18.0);

/// 25
const Widget verticalSpaceMedium = SizedBox(height: 25.0);

/// 50
const Widget verticalSpaceLarge = SizedBox(height: 50.0);

// !SECTION

// SECTION[epic=Screen Size helpers]
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;

// !SECTION

// SECTION[epic=Cupertino Modal Constants]

// const double kPreviousPageVisibleOffset = 10;

// const Radius kDefaultTopRadius = Radius.circular(12);
// const BoxShadow kDefaultBoxShadow =
//     BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5);

// !SECTION

// SECTION[epic=Card Shapes and Border]

const BorderSide kDefaultCardBorderSide = BorderSide(
  // This color is as per the native iOS
  // NOTE DO NOT CHANGE
  color: Color(0x4D000000),
  width: 0.0, // One physical pixel.
  style: BorderStyle.solid,
);

ShapeBorder kRoundedCardBorder(
        {double radius = 12, BorderSide side = BorderSide.none}) =>
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      side: side,
    );


// !SECTION