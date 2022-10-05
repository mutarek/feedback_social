import 'dart:io';

import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  // final ProfileRepo profileRepo;
  // final AuthRepo authRepo;
  //
  // ProfileProvider({required this.profileRepo, required this.authRepo});
  //
  // bool _isLoading = false;
  //
  // bool get isLoading => _isLoading;
  //
  // // get All address
  // List<Address> address = [];
  // int selectAddressIndex = 0;
  // Address selectDefaultAddress = Address(
  //     id: -1,
  //     address: '',
  //     city: City(name: '', id: 0, image: '', version: 0),
  //     country: Country(image: '', id: 0, name: '', version: 0),
  //     state: '',
  //     location: Location(),
  //     isDefault: false);
  //
  // initializeAllAddress(BuildContext context) async {
  //   _isLoading = true;
  //   address.clear();
  //   address = [];
  //   selectAddressIndex = 0;
  //   selectDefaultAddress = Address(
  //       id: -1,
  //       address: '',
  //       city: City(name: '', id: 0, image: '', version: 0),
  //       country: Country(image: '', id: 0, name: '', version: 0),
  //       state: '',
  //       location: Location(),
  //       isDefault: false);
  //   ApiResponse apiResponse = await profileRepo.getCustomerAddress();
  //   _isLoading = false;
  //   if (apiResponse.response.statusCode == 200) {
  //     apiResponse.response.data['value'].forEach((element) {
  //       if (Address.fromJson(element).isDefault!) {
  //         selectDefaultAddress = Address.fromJson(element);
  //       }
  //       address.add(Address.fromJson(element));
  //     });
  //   } else {
  //     //showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
  //     address = [];
  //   }
  //   notifyListeners();
  // }
  //
  // changeAddressSelectIndex(int index) {
  //   selectAddressIndex = index;
  //   notifyListeners();
  // }
  //
  // // get all countries
  // List<Country> countries = [];
  // Country? selectCountries;
  // bool _isLoadingCountries = false;
  //
  // bool get isLoadingCountries => _isLoadingCountries;
  //
  // initializeAllCountry(BuildContext context) async {
  //   _isLoadingCountries = true;
  //   countries.clear();
  //   countries = [];
  //   ApiResponse apiResponse = await profileRepo.getCountries();
  //   _isLoadingCountries = false;
  //   if (apiResponse.response.statusCode == 200) {
  //     apiResponse.response.data['value'].forEach((element) {
  //       countries.add(Country.fromJson(element));
  //     });
  //     selectCountries = countries[0];
  //     initializeAllCity(context, selectCountries!.id);
  //     notifyListeners();
  //   } else {
  //     showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
  //   }
  // }
  //
  // changeCountry(Country c, BuildContext context) {
  //   selectCountries = c;
  //   initializeAllCity(context, c.id);
  //   notifyListeners();
  // }
  //
  // // get all Cities
  // List<City> cities = [];
  // City? selectCity;
  // bool _isLoadingCity = false;
  //
  // bool get isLoadingCity => _isLoadingCity;
  //
  // initializeAllCity(BuildContext context, int countryID) async {
  //   _isLoadingCity = true;
  //   cities.clear();
  //   cities = [];
  //   ApiResponse apiResponse = await profileRepo.getCitiesByCountryID(countryID);
  //   _isLoadingCity = false;
  //   if (apiResponse.response.statusCode == 200) {
  //     apiResponse.response.data['value'].forEach((element) {
  //       cities.add(City.fromJson(element));
  //     });
  //     if (countryID == 11) {
  //       selectCity = cities[cities.length - 9];
  //     } else {
  //       selectCity = cities[0];
  //     }
  //
  //     notifyListeners();
  //   } else {
  //     showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
  //   }
  // }
  //
  // changeCities(City c, BuildContext context) {
  //   selectCity = c;
  //   notifyListeners();
  // }
  //
  // //
  // // for Remember Me Section
  //
  // bool _isActiveRememberMe = true;
  //
  // bool get isDefault => _isActiveRememberMe;
  //
  // toggleRememberMe() {
  //   _isActiveRememberMe = !_isActiveRememberMe;
  //   notifyListeners();
  // }
  //
  // // add address
  // bool _isLoadingAddAddress = false;
  //
  // bool get isLoadingAddAddress => _isLoadingAddAddress;
  //
  // addEditAddress(Map address, BuildContext context, Function callBack, {bool isEdit = false}) async {
  //   _isLoadingAddAddress = true;
  //   notifyListeners();
  //   ApiResponse apiResponse;
  //   if (isEdit) {
  //     apiResponse = await profileRepo.editAddress(address);
  //   } else {
  //     apiResponse = await profileRepo.addAddress(address);
  //   }
  //   _isLoadingAddAddress = false;
  //   if (apiResponse.response.statusCode == 201 || apiResponse.response.statusCode == 200) {
  //     showScaffoldSnackBar(context: context, message: apiResponse.response.data['message'], isError: false);
  //     initializeAllAddress(context);
  //     callBack(true);
  //   } else {
  //     print(apiResponse.error.toString());
  //     showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
  //     callBack(false);
  //   }
  //   notifyListeners();
  // }
  //
  // deleteAddress(BuildContext context, String addressID) async {
  //   _isLoading = true;
  //   ApiResponse apiResponse = await profileRepo.deleteAddress(addressID);
  //   _isLoading = false;
  //   if (apiResponse.response.statusCode == 200) {
  //     showScaffoldSnackBar(context: context, message: apiResponse.response.data['message'], isError: false);
  //     initializeAllAddress(context);
  //   } else {
  //     showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
  //   }
  //   notifyListeners();
  // }
  //
  // // get User
  // ProfileModel? user;
  //
  // getUserProfiles(BuildContext context) async {
  //   _isLoading = true;
  //   ApiResponse apiResponse = await profileRepo.getCustomerProfile();
  //   _isLoading = false;
  //   if (apiResponse.response.statusCode == 200) {
  //     user = ProfileModel.fromJson(apiResponse.response.data['value']);
  //     print(user!.toJson());
  //   } else {
  //     showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
  //   }
  //   notifyListeners();
  // }
  //
  // String _profileImage = '';
  //
  // String get profileImage => _profileImage;
  // bool isLoadingUpload = false;
  //
  // updateProfileImage(BuildContext context, File file) async {
  //   _profileImage = '';
  //   isLoadingUpload = true;
  //   notifyListeners();
  //   ApiResponse apiResponse = await profileRepo.uploadPhoto(file);
  //   isLoadingUpload = false;
  //   if (apiResponse.response.statusCode == 200) {
  //     _profileImage = apiResponse.response.data['uploadedFiles'][0]['filePath'];
  //
  //     Map map = {
  //       "firstname": user!.firstname,
  //       "lastname": user!.lastname,
  //       "age": user!.age,
  //       "email": 'test@gmail.com',
  //       "mobile": user!.mobile,
  //       "birthday": user!.birthday,
  //       "darkMode": user!.darkMode,
  //       "image": _profileImage
  //     };
  //
  //     updateProfile(context, map);
  //
  //     showCustomSnackBar("Profile Picture Upload Successfully", context, isError: false);
  //   } else {
  //     showCustomSnackBar(apiResponse.error.toString(), context);
  //   }
  //   notifyListeners();
  // }
  //
  // bool isUpdateProfilePassword = false;
  //
  // updateProfile(BuildContext context, Map map) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   ApiResponse apiResponse = await profileRepo.updateProfile(map);
  //   _isLoading = false;
  //   if (apiResponse.response.statusCode == 200) {
  //     user = ProfileModel.fromJson(apiResponse.response.data['value']);
  //     showCustomSnackBar(apiResponse.response.data['message'], context, isError: false);
  //     authRepo.clearFirstName();
  //     authRepo.saveFirstName(user!.firstname!);
  //   } else {
  //     showCustomSnackBar(apiResponse.error.toString(), context);
  //   }
  //   notifyListeners();
  // }
  //
  // bool _isLoadingPassword = false;
  //
  // bool get isLoadingPassword => _isLoadingPassword;
  //
  // updatePassword(BuildContext context, Map<String, dynamic> map, Function callBack) async {
  //   _isLoadingPassword = true;
  //   notifyListeners();
  //   ApiResponse apiResponse = await profileRepo.updatePassword(map);
  //   _isLoadingPassword = false;
  //   if (apiResponse.response.statusCode == 200) {
  //     showCustomSnackBar(apiResponse.response.data['message'], context, isError: false);
  //     callBack(true);
  //   } else {
  //     showCustomSnackBar(apiResponse.error.toString(), context);
  //     callBack(false);
  //   }
  //   notifyListeners();
  // }
  //
  // bool isMaximize = false;
  //
  // changeMaximize({bool isFirstTime = false}) {
  //   if (isFirstTime) {
  //     isMaximize = true;
  //   } else {
  //     isMaximize = true;
  //     notifyListeners();
  //   }
  // }
}
