import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/db/db_helper.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/tv_local_ds.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/data/datasources/tv_remote_ds.dart';
import 'package:submission_one_menjadi_flutter_developer_expert_ditonton_app/domain/repositories/tv_show_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TVShowRepo,
  TVRemoteDS,
  TVLocalDS,
  DBHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
