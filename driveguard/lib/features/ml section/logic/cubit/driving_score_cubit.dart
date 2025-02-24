import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'driving_score_state.dart';

class DrivingScoreCubit extends Cubit<DrivingScoreState> {
  DrivingScoreCubit() : super(DrivingScoreInitial());
}
