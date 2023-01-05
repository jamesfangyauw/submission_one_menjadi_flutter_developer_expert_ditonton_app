import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/common/mapper/mapper.dart';

abstract class MapperList<M, I> extends Mapper<List<M>, List<I>> {}

class ListMapperImpl<M, I> implements MapperList<M, I> {
  final Mapper<M, I> mapper_list_impl;

  ListMapperImpl(this.mapper_list_impl);

  @override
  List<I> map(List<M> input) {
    return input.map((t) => mapper_list_impl.map(t)).toList();
  }
}
