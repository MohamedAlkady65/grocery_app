
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/constants/enums.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/data/models/phone_model.dart';
import 'package:grocery_app/data/services/addresses_services.dart';
import 'package:grocery_app/helper/phone.dart';
import 'package:grocery_app/logic/addresses_cubit/address_fields.dart';
import 'package:grocery_app/logic/info_cubit/info_cubit.dart';
import 'package:meta/meta.dart';
import 'package:phone_number/phone_number.dart';

part 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  AddressesCubit({required this.infoCubit}) : super(AddressesInitial());
  InfoCubit infoCubit;
  AddressesServices addressesServices = AddressesServices();

  AddressData addressData = AddressData();
  EditAddressData editAddressData = EditAddressData();

  GlobalKey<FormState> formKey = GlobalKey();

  bool isThereEditing = false;

  List<AddressModel> addresses = [];
  String? defaultAddressId;

  String? phoneFieldErrorMessage;
  void add(BuildContext context) async {
    formKey.currentState!.save();
    await validatePhone(context);

    if (formKey.currentState!.validate()) {
      emit(AddAddressLoading());
      final AddressModel address =
          AddressModel.fromJson(data: addressData.toJson());

      if (addresses.isEmpty) {
        addressData.isDefault = true;
      }

      final response = await addressesServices.add(address: address);

      if (response == DataResponse.success) {
        if (addressData.isDefault) {
          final defaultResponse = await setDefault(addressId: address.id);
          if (defaultResponse == DataResponse.failure) {
            addressesServices.removeAddress(addressId: address.id!);
            emit(AddAddressFailure());
            addressData.clear();
            return;
          }
        }

        addresses
            .firstWhereOrNull((element) => element.isExpanded)
            ?.isExpanded = false;
        addresses.insert(0, address);

        emit(AddAddressSuccess());
        emit(GetAddressesSuccess());
      } else {
        emit(AddAddressFailure());
      }
      addressData.clear();
    }
  }

  Future<void> validatePhone(BuildContext context) async {
    final countryCode = infoCubit.ipInfo?.countryCode2;
    PhoneNumber? phoneNumber = await PhoneParser.parse(
        phone: addressData.phoneText, code: countryCode);

    if (phoneNumber == null) {
      phoneFieldErrorMessage = "Please enter valid phone number";
    } else {
      phoneFieldErrorMessage = null;
      addressData.phone = PhoneModel.fromPhoneNumberObject(phoneNumber);
    }
  }

  Future<DataResponse> setDefault({required String? addressId}) async {
    final res = await addressesServices.setDefault(addressId);

    if (res == DataResponse.success) {
      defaultAddressId = addressId;
      return DataResponse.success;
    } else {
      return DataResponse.failure;
    }
  }

  void getAddresses() async {
    emit(GetAddressesLoading());
    final response = await addressesServices.getAddresses();
    if (response.state == DataResponse.success) {
      addresses = response.data.reversed.toList();
      defaultAddressId = response.defaultAddressId;
      emit(GetAddressesSuccess());
    } else {
      emit(GetAddressesFailure());
    }
  }

  Future<void> removeAddress({required String addressId}) async {
    emit(RemoveAddresseLoading());
    var response = await addressesServices.removeAddress(addressId: addressId);

    if (response == DataResponse.success) {
      addresses.removeWhere((element) => element.id == addressId);
      if (addressId == defaultAddressId) {
        await setDefault(
            addressId: addresses.isNotEmpty ? addresses[0].id : null);
      }
      emit(RemoveAddresseSuccess());
    } else {
      emit(RemoveAddresseFailure());
    }
    emit(GetAddressesSuccess());
  }

  Future<void> editAddress(
      {required String addressId,
      required BuildContext context,
      required GlobalKey<FormState> formKey,
      required void Function() setState}) async {
    await editAddressData.validatePhone(context, infoCubit);
    if (formKey.currentState!.validate()) {
      if (editAddressData.id != addressId) {
        editAddressData.clear();
        setState();
        return;
      }
      emit(EditAddresseLoading());
      var response = await addressesServices.editAddress(
          addressId: editAddressData.id!, data: editAddressData.toJson());
      if (response == DataResponse.success) {
        if (editAddressData.isDefault == true) {
          await setDefault(addressId: addressId);
        }
        refreshEditedData(addressId);
        emit(EditAddresseSuccess());
      } else {
        emit(EditAddresseFailure());
      }
      editAddressData.clear();
      emit(GetAddressesSuccess());
      setState();
    }
  }

  void refreshEditedData(String addressId) {
    final address = addresses.firstWhere((element) => element.id == addressId);

    address.name = editAddressData.name ?? address.name;
    address.street = editAddressData.street ?? address.street;
    address.countryCode = editAddressData.country ?? address.countryCode;
    address.city = editAddressData.city ?? address.city;
    address.zip = editAddressData.zip ?? address.zip;
    address.phone = editAddressData.phone ?? address.phone;
  }

  @override
  void emit(AddressesState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
