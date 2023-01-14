import 'package:equatable/equatable.dart';

abstract class FailureEquitable extends Equatable {
  final String mssg;
  FailureEquitable(this.mssg);
  List<Object> get props => [mssg];
}
class FailureServer extends FailureEquitable {
  FailureServer(String mssg) : super(mssg);
}
class FailureConnection extends FailureEquitable {
  FailureConnection(String mssg) : super(mssg);
}
class FailureDB extends FailureEquitable {
  FailureDB(String mssg) : super(mssg);
}
class FailureCommon extends FailureEquitable {
   FailureCommon(String mssg) : super(mssg);
}

