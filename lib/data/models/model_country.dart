import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/country_entities.dart';
import 'package:equatable/equatable.dart';

class ModelCountry extends Equatable {
  ModelCountry({
    required this.idCountry,
    required this.nameCountry,
  });

  final int idCountry;
  final String nameCountry;

  factory ModelCountry.fromJson(Map<String, dynamic> json) => ModelCountry(
        idCountry: json["id"],
        nameCountry: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": idCountry,
        "name": nameCountry,
      };

  CountryEntities toEntity() {
    return CountryEntities(idCountry: this.idCountry, nameCountry: this.nameCountry);
  }

  List<Object?> get props => [idCountry, nameCountry];
}
