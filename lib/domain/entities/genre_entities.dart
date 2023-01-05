import 'package:equatable/equatable.dart';

class GenreEntities extends Equatable {
  GenreEntities({
    required this.idGenre,
    required this.nameGenre,
  });
  final int idGenre;
  final String nameGenre;

  List<Object> get props => [idGenre, nameGenre];
}
