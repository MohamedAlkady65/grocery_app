part of 'addresses_cubit.dart';

@immutable
sealed class AddressesState {}

final class AddresseRemove extends AddressesState {}

final class AddresseEdit extends AddressesState {}

final class AddressesInitial extends AddressesState {}

final class AddAddressState extends AddressesState {}

final class GetAddressesState extends AddressesState {}

final class AddAddressSuccess extends AddAddressState {}

final class AddAddressFailure extends AddAddressState {}

final class AddAddressLoading extends AddAddressState {}

final class GetAddressesSuccess extends GetAddressesState {}

final class GetAddressesFailure extends GetAddressesState {}

final class GetAddressesLoading extends GetAddressesState {}

final class RemoveAddresseLoading extends AddresseRemove {}

final class RemoveAddresseSuccess extends AddresseRemove {}

final class RemoveAddresseFailure extends AddresseRemove {}

final class EditAddresseLoading extends AddresseEdit {}

final class EditAddresseSuccess extends AddresseEdit {}

final class EditAddresseFailure extends AddresseEdit {}
