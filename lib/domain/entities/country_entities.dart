import 'package:equatable/equatable.dart';

class CountryEntities extends Equatable {
  CountryEntities({
    required this.idCountry,
    required this.nameCountry,
  });

  final int idCountry;
  final String nameCountry;

  List<Object> get props => [idCountry, nameCountry];
}
