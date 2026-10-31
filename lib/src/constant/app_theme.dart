
import 'package:flutter/material.dart';

class AppTheme {
  final TextTheme textTheme;

  const AppTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xffB94F68),
      surfaceTint: Color(0xffB94F68),
      onPrimary: Color(0xffFFFFFF),
      primaryContainer: Color(0xffFFD9E0),
      onPrimaryContainer: Color(0xff6D2038),
      secondary: Color(0xff8A6973),
      onSecondary: Color(0xffFFFFFF),
      secondaryContainer: Color(0xffF5DCE3),
      onSecondaryContainer: Color(0xff6B4D56),
      tertiary: Color(0xff886C4E),
      onTertiary: Color(0xffFFFFFF),
      tertiaryContainer: Color(0xffF4E3C9),
      onTertiaryContainer: Color(0xff624A30),
      error: Color(0xffBA1A1A),
      onError: Color(0xffFFFFFF),
      errorContainer: Color(0xffFFDAD6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xffFFF8F2),
      onSurface: Color(0xff382E30),
      onSurfaceVariant: Color(0xff78676C),
      outline: Color(0xffA28D91),
      outlineVariant: Color(0xffE8D7D7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382F31),
      inversePrimary: Color(0xffF4B2BF),
      primaryFixed: Color(0xffFFD9E0),
      onPrimaryFixed: Color(0xff3F0018),
      primaryFixedDim: Color(0xffF4B2BF),
      onPrimaryFixedVariant: Color(0xff922E4C),
      secondaryFixed: Color(0xffF5DCE3),
      onSecondaryFixed: Color(0xff38212A),
      secondaryFixedDim: Color(0xffDDBFC8),
      onSecondaryFixedVariant: Color(0xff70535D),
      tertiaryFixed: Color(0xffF4E3C9),
      onTertiaryFixed: Color(0xff2E1D08),
      tertiaryFixedDim: Color(0xffE5C6A5),
      onTertiaryFixedVariant: Color(0xff6D5236),
      surfaceDim: Color(0xffE7D9D4),
      surfaceBright: Color(0xffFFF8F2),
      surfaceContainerLowest: Color(0xffFFFFFF),
      surfaceContainerLow: Color(0xffFFF1EC),
      surfaceContainer: Color(0xffF9EAE5),
      surfaceContainerHigh: Color(0xffF2E3DF),
      surfaceContainerHighest: Color(0xffEBDCD8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffF4B2BF),
      surfaceTint: Color(0xffF4B2BF),
      onPrimary: Color(0xff641B32),
      primaryContainer: Color(0xff922E4C),
      onPrimaryContainer: Color(0xffFFD9E0),
      secondary: Color(0xffDDBFC8),
      onSecondary: Color(0xff402A33),
      secondaryContainer: Color(0xff70535D),
      onSecondaryContainer: Color(0xffF5DCE3),
      tertiary: Color(0xffE5C6A5),
      onTertiary: Color(0xff463017),
      tertiaryContainer: Color(0xff6D5236),
      onTertiaryContainer: Color(0xffF4E3C9),
      error: Color(0xffFFB4AB),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000A),
      onErrorContainer: Color(0xffFFDAD6),
      surface: Color(0xff211D22),
      onSurface: Color(0xffF3E6E5),
      onSurfaceVariant: Color(0xffD5C2C6),
      outline: Color(0xffA9959A),
      outlineVariant: Color(0xff514348),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffF3E6E5),
      inversePrimary: Color(0xffB94F68),
      primaryFixed: Color(0xffFFD9E0),
      onPrimaryFixed: Color(0xff3F0018),
      primaryFixedDim: Color(0xffF4B2BF),
      onPrimaryFixedVariant: Color(0xff922E4C),
      secondaryFixed: Color(0xffF5DCE3),
      onSecondaryFixed: Color(0xff38212A),
      secondaryFixedDim: Color(0xffDDBFC8),
      onSecondaryFixedVariant: Color(0xff70535D),
      tertiaryFixed: Color(0xffF4E3C9),
      onTertiaryFixed: Color(0xff2E1D08),
      tertiaryFixedDim: Color(0xffE5C6A5),
      onTertiaryFixedVariant: Color(0xff6D5236),
      surfaceDim: Color(0xff211D22),
      surfaceBright: Color(0xff494047),
      surfaceContainerLowest: Color(0xff19151A),
      surfaceContainerLow: Color(0xff2A242A),
      surfaceContainer: Color(0xff302930),
      surfaceContainerHigh: Color(0xff3B333A),
      surfaceContainerHighest: Color(0xff463D44),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily dark;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.dark,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
