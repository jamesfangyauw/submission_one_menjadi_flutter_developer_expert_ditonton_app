import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/mapper/mapper.dart';

abstract class MapperListNullableOutput<M, I>
    extends Mapper<List<M>, List<I>?> {}

class MapperListNullableOutputImpl<M, I>
    implements MapperListNullableOutput<M, I> {
  final Mapper<M, I> mapper_list;

  MapperListNullableOutputImpl(this.mapper_list);

  @override
  List<I>? map(List<M> input_mapper) {
    if (input_mapper.isEmpty) {
      return null;
    }

    input_mapper.map((t) => mapper_list.map(t));
  }
}
