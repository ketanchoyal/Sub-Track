part of "shared.dart";

enum TextFieldType {
  DEFAULT,
  ACTIVE,
  VALID,
  ERROR,
  DISABLED,
}

enum ButtonType {
  PRIMARY,
  SECONDARY,
  TERTIARY,
  DISABLED,
  ICON,
}

enum IconType {
  Services,
  Emoji,
}

/// String extesions for enums
extension IconTypeExtension on IconType {
  String get convertToString => this.toString().split('.')[1];
}

enum OtherDetailSelectType {
  Renews_Every,
  Notification,
}

extension OtherDetailSelectTypeX on OtherDetailSelectType {
  String get name {
    switch (this) {
      case OtherDetailSelectType.Renews_Every:
        return "Renews Every";
      case OtherDetailSelectType.Notification:
        return "Notification";
    }
  }
}
