import 'package:flutter/material.dart';

const Color black = Color(0xFF000814);
const Color pOxfordBlue = Color(0xFF001D3D);
const Color pDavysGrey = Color(0xFF4B5358);
const Color pGrey = Color(0xFF303030);
const Color pPrussianBlue = Color(0xFF003566);
const Color pMikadoYellow = Color(0xFFffc300);

const pColorScheme = ColorScheme(
  primary: pMikadoYellow,
  primaryVariant: pMikadoYellow,
  secondary: pPrussianBlue,
  secondaryVariant: pPrussianBlue,
  surface: black,
  background: black,
  error: Colors.red,
  onPrimary: black,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);