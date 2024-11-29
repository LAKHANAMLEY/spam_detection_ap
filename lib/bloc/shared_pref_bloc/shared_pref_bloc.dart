import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spam_delection_app/bloc/shared_pref_bloc/shared_pref_event.dart';
import 'package:spam_delection_app/bloc/shared_pref_bloc/shared_pref_state.dart';
import 'package:spam_delection_app/data/shared_pref/shared_pref.dart';
import 'package:spam_delection_app/models/user_model.dart';

class SharedPrefBloc extends Bloc<SharedPrefEvent, SharedPrefState> {
  SharedPrefBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(
      SharedPrefEvent event, Emitter<SharedPrefState> emit) async {
    if (event is GetUserDataFromLocalEvent) {
      final userId = await SharedPref.getUserId();
      final corporateId = await SharedPref.getCorporateId();
      final token = await SharedPref.getToken();
      final crn = await SharedPref.getCrn();
      final name = await SharedPref.getName();
      final firstName = await SharedPref.getName();
      final lastname = await SharedPref.getName();
      final userName = await SharedPref.getUserName();
      final email = await SharedPref.getEmail();
      final phone = await SharedPref.getPhone();
      final photo = await SharedPref.getPhoto();
      final gender = await SharedPref.getGender();
      final dob = await SharedPref.getDOB();
      final country = await SharedPref.getCountry();
      final countryCode = await SharedPref.getCountryCode();
      final countryId = await SharedPref.getCountryId();
      final state = await SharedPref.getState();
      final city = await SharedPref.getCity();
      final zip = await SharedPref.getZip();
      final address = await SharedPref.getAddress();
      final address2 = await SharedPref.getAddress2();
      var user = User(
        userId: userId,
        corporateId: corporateId,
        crn: crn,
        name: name,
        firstName: firstName,
        lastName: lastname,
        userName: userName,
        email: email,
        phone: phone,
        photo: photo,
        gender: gender,
        dob: DateTime.tryParse(dob),
        country: country,
        state: state,
        city: city,
        zip: zip,
        address: address,
        address2: address2,
        countryCode: countryCode,
        countryId: countryId,
        token: token,
      );
      emit(GetUserDataFromLocalState(user));
    }
  }
}
