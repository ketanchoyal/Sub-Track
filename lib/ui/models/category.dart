import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Category {
  final String name;
  final IconData icon;
  final String hex;

  Category({
    required this.name,
    required this.icon,
    required this.hex,
  });

  final List<Category> categories = [
    Category(name: "News", icon: CupertinoIcons.news_solid, hex: "8E8E93"),
    Category(
        name: "LisfeStyle", icon: CupertinoIcons.news_solid, hex: "5856D6"),
    Category(
        name: "Transportation", icon: CupertinoIcons.news_solid, hex: "007AFF"),
    Category(
        name: "Money",
        icon: CupertinoIcons.money_dollar_circle_fill,
        hex: "34C759"),
    Category(
        name: "Food & Drinks", icon: Icons.food_bank_rounded, hex: "FF9500"),
    Category(
        name: "Medical", icon: Icons.medical_services_rounded, hex: "FF2D55"),
    Category(
        name: "Gaming",
        icon: CupertinoIcons.gamecontroller_fill,
        hex: "34C759"),
    Category(name: "Tools", icon: CupertinoIcons.wrench_fill, hex: "FF9500"),
    Category(
        name: "Cloud Storage", icon: CupertinoIcons.cloud_fill, hex: "007AFF"),
    Category(name: "Study", icon: CupertinoIcons.book_fill, hex: "FF9500"),
    Category(name: "Finance", icon: Icons.receipt_rounded, hex: "34C759"),
    Category(
        name: "Household", icon: CupertinoIcons.house_alt_fill, hex: "FF9500"),
    // Category(name: "Taxes", icon: "doc.plaintext.fill", hex: "FF453A"),
    Category(
        name: "Insurance",
        icon: CupertinoIcons.checkmark_shield_fill,
        hex: "8E8E93"),
    Category(name: "Streaming", icon: CupertinoIcons.tv_fill, hex: "5856D6"),
    Category(name: "Internet", icon: CupertinoIcons.globe, hex: "007AFF"),
    Category(name: "Essentials", icon: CupertinoIcons.star_fill, hex: "FFCC00"),
    Category(
        name: "Social Networking",
        icon: CupertinoIcons.square_arrow_up_fill,
        hex: "007AFF"),
    Category(name: "Music", icon: CupertinoIcons.music_note, hex: "FF2D55"),
    Category(
        name: "Business", icon: CupertinoIcons.chart_pie_fill, hex: "007AFF"),
    Category(name: "Utilities", icon: CupertinoIcons.bolt_fill, hex: "FFCC00"),
    Category(
        name: "Sports", icon: CupertinoIcons.sportscourt_fill, hex: "FF3B30"),
    Category(
        name: "Donations", icon: CupertinoIcons.smiley_fill, hex: "34C759"),
    Category(name: "Travel", icon: CupertinoIcons.airplane, hex: "8E8E93"),
    Category(
        name: "Services", icon: CupertinoIcons.building_2_fill, hex: "AF52DE"),
    Category(name: "Pets", icon: CupertinoIcons.tortoise_fill, hex: "FFD600"),
    Category(
        name: "Communication",
        icon: CupertinoIcons.bubble_left_bubble_right_fill,
        hex: "34C759"),
    Category(name: "Default", icon: CupertinoIcons.question, hex: "8E8E93"),
    Category(name: "Shopping", icon: CupertinoIcons.bag_fill, hex: "007AFF"),
    Category(name: "Clothing", icon: CupertinoIcons.eyeglasses, hex: "007AFF"),
    Category(
        name: "Entertainment", icon: CupertinoIcons.ticket_fill, hex: "34C759"),
    Category(
        name: "Miscellaneous", icon: CupertinoIcons.tag_fill, hex: "8E8E93"),
    Category(
        name: "Child Expenses",
        icon: CupertinoIcons.person_2_fill,
        hex: "5AC8FA"),
    Category(
        name: "Photo & Video", icon: CupertinoIcons.camera_fill, hex: "5AC8FA"),
    Category(
        name: "Health & Fitness",
        icon: Icons.directions_walk_rounded,
        hex: "FF3B30"),
    Category(
        name: "Employment", icon: CupertinoIcons.briefcase_fill, hex: "FF9500"),
    Category(
        name: "Personal Care", icon: CupertinoIcons.person_fill, hex: "FF2D55"),
    Category(
        name: "Productivity", icon: CupertinoIcons.sunrise_fill, hex: "FFCC00"),
    Category(
        name: "Memberships",
        icon: CupertinoIcons.creditcard_fill,
        hex: "FF9500"),
    // Category(name: "Education", icon: "graduationcap.fill", hex: "FF9500"),
    Category(
        name: "Books", icon: CupertinoIcons.book_circle_fill, hex: "007AFF")
  ];
}
