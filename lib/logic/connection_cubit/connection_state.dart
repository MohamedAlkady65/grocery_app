part of 'connection_cubit.dart';

@immutable
sealed class CheckConnectionState {}

final class ConnectionInitial extends CheckConnectionState {}

final class ConnectionFailure extends CheckConnectionState {}

final class ConnectionSuccess extends CheckConnectionState {}

final class ConnectionLoading extends CheckConnectionState {}
