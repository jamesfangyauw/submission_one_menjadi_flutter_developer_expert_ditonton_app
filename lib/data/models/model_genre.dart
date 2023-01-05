import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/entities/genre_entities.dart';
import 'package:equatable/equatable.dart';

class ModelGenre extends Equatable {
  ModelGenre({
    required this.idGenre,
    required this.nameGenre,
  });

  final int idGenre;
  final String nameGenre;

  factory ModelGenre.fromJson(Map<String, dynamic> json) => ModelGenre(
        idGenre: json["id"],
        nameGenre: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": idGenre,
        "name": nameGenre,
      };

  GenreEntities toEntity() {
    return GenreEntities(idGenre: this.idGenre, nameGenre: this.nameGenre);
  }

  List<Object?> get props => [idGenre, nameGenre];
}
