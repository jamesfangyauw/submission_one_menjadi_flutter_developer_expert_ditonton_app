import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/mapper/mapper.dart';

abstract class MapperListNullableInput<M, I> extends Mapper<List<M>?, List<I>> {
}

class MapperListNullableInputImpl<M, I>
    implements MapperListNullableInput<M, I> {
  final Mapper<M, I> mapper_list_implk;

  MapperListNullableInputImpl(this.mapper_list_implk);

  @override
  List<I> map(List<M>? input_mapper) {
    if (input_mapper == null) {
      return [];
    }
    return input_mapper.map((t) => mapper_list_implk.map(t)).toList();
  }
}
