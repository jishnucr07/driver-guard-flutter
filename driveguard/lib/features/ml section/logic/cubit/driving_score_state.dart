part of 'driving_score_cubit.dart';

@immutable
sealed class DrivingScoreState {}

final class DrivingScoreInitial extends DrivingScoreState {}

final class DrivingScoreSuccessState extends DrivingScoreState {
  final double drivingScore;

  DrivingScoreSuccessState(this.drivingScore);
}

final class DrivingScoreInProgressState extends DrivingScoreState {}

final class DrivingScoreFailState extends DrivingScoreState {}
