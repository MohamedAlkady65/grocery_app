part of 'landing_cubit.dart';

@immutable
sealed class LandingState {}

final class LandingInitial extends LandingState {}

final class LandingLoading extends LandingState {}

final class LandingSuccess extends LandingState {}

final class LandingFailure extends LandingState {

}
