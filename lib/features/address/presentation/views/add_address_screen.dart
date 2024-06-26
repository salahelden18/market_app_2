import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/address_model.dart';
import '../../data/models/address_request_model.dart';
import '../model_views/add_edit_address/add_edit_address_cubit.dart';
import '../model_views/add_edit_address/add_edit_address_states.dart';
import '../model_views/address_cubit.dart';
import '../../../home/presentation/view_models/location_and_gps_cubit/location_and_gps_cubit.dart';
import '../../../../core/widget/filled_button_widget.dart';
import '../../../../core/style/font_style.dart';
import '../../../../core/utils/dialog_manager_overlay.dart';
import '../../../../core/utils/show_toast.dart';
import '../../../../core/widget/custome_text_form_field.dart';
import '../../../../core/widget/dropdown_button_form_field_widget.dart';
import '../../../../core/widget/loading_widget.dart';
import '../model_views/address_common_cubit/address_common_cubit.dart';
import '../model_views/address_common_cubit/address_common_states.dart';

class AddAddresssScreen extends StatefulWidget {
  const AddAddresssScreen({super.key});
  static const String routeName = "/add-address-screen";

  @override
  State<AddAddresssScreen> createState() => _AddAddresssScreenState();
}

class _AddAddresssScreenState extends State<AddAddresssScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String? selectedCountryId;
  String? selectedCityId;
  String? selectedDistrictId;
  String? selectedSubDistrictId;
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController fullAddressController = TextEditingController();
  final TextEditingController additionalInfoController =
      TextEditingController();
  bool isExecuted = false;
  AddressModel? addressModel;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!isExecuted) {
      addressModel =
          ModalRoute.of(context)?.settings.arguments as AddressModel?;

      // adding the fields if it is exist
      apartmentController.text = addressModel?.apartment ?? '';
      floorController.text = addressModel?.floor ?? '';
      flatController.text =
          '${addressModel?.flatNumber != null ? addressModel!.flatNumber : ''}';
      fullAddressController.text = addressModel?.fullAddress ?? '';
      additionalInfoController.text = addressModel?.additionalInfo ?? '';
      setState(() {
        isLoading = true;
      });

      await context.read<AddressCommonCubit>().getCountries();

      setState(() {
        isLoading = false;
      });
      isExecuted = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    apartmentController.dispose();
    flatController.dispose();
    floorController.dispose();
    fullAddressController.dispose();
    additionalInfoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(addressModel == null ? 'Add Address' : 'Edit Address'),
      ),
      body: isLoading
          ? const LoadingWidget()
          : BlocConsumer<AddressCommonCubit, AddressCommonStates>(
              listener: (context, state) {
                if (state.isLoading) {
                  DialogManagerOverlay.showDialogWithMessage(context);
                } else if (state.hasError) {
                  showToast(context: context, msg: state.errorMessage!);
                  DialogManagerOverlay.closeDialog();
                } else {
                  DialogManagerOverlay.closeDialog();
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(10),
                    children: [
                      if (addressModel == null)
                        // Country
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Country',
                              style: FontStyle.size22Black600,
                            ),
                            DropdownButtonFormFieldWidget(
                              hint: 'Select Country',
                              selectedValue: selectedCountryId,
                              items: state.countries
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.enName),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (newValue) {
                                if (selectedCountryId != newValue) {
                                  selectedCountryId = newValue;
                                  context
                                      .read<AddressCommonCubit>()
                                      .getCities(newValue);
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      // City
                      if (state.countries.isNotEmpty &&
                          selectedCountryId != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'City',
                              style: FontStyle.size22Black600,
                            ),
                            DropdownButtonFormFieldWidget(
                              hint: 'Select City',
                              selectedValue: selectedCityId,
                              items: state.cities
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.enName),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (newValue) {
                                if (selectedCityId != newValue) {
                                  selectedCityId = newValue;
                                  context
                                      .read<AddressCommonCubit>()
                                      .getDistrict(newValue);
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      // District
                      if (state.cities.isNotEmpty && selectedCityId != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'District',
                              style: FontStyle.size22Black600,
                            ),
                            DropdownButtonFormFieldWidget(
                              hint: 'Select District',
                              selectedValue: selectedDistrictId,
                              items: state.districts
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.enName),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (newValue) {
                                if (selectedDistrictId != newValue) {
                                  selectedDistrictId = newValue;
                                  context
                                      .read<AddressCommonCubit>()
                                      .getSubDistrict(newValue);
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      // SubDistrict
                      if (state.districts.isNotEmpty &&
                          selectedDistrictId != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'Sub district',
                              style: FontStyle.size22Black600,
                            ),
                            DropdownButtonFormFieldWidget(
                              hint: 'Select Sub district',
                              selectedValue: selectedSubDistrictId,
                              items: state.subdistricts
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.enName),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (newValue) {
                                selectedSubDistrictId = newValue;
                                setState(() {});
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      // the additional fields
                      if (selectedSubDistrictId != null || addressModel != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter apartment';
                                }
                                return null;
                              },
                              controller: apartmentController,
                              label: 'Apartment',
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter floor number';
                                      }
                                      return null;
                                    },
                                    controller: floorController,
                                    label: 'Floor Number',
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter flat number';
                                      }
                                      return null;
                                    },
                                    controller: flatController,
                                    label: 'Flat Number',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(
                                          r'[0-9]')), // Allow only numbers
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your full address';
                                }
                                return null;
                              },
                              controller: fullAddressController,
                              label: 'Full Address',
                            ),
                            const SizedBox(height: 10),
                            CustomTextFormField(
                              controller: additionalInfoController,
                              label: 'Additional Information',
                            ),
                            const SizedBox(height: 20),
                            BlocListener<AddEditAddressCubit,
                                AddEditAddressStates>(
                              listener: (context, state) {
                                if (state is AddEditAddressLoadingState) {
                                  DialogManagerOverlay.showDialogWithMessage(
                                      context);
                                } else if (state
                                    is AddEditAddressFailureState) {
                                  DialogManagerOverlay.closeDialog();
                                  showToast(
                                      context: context,
                                      msg: state.errorMessage);
                                } else if (state
                                    is AddEditAddressSuccessState) {
                                  if (addressModel == null) {
                                    context
                                        .read<AddressCubit>()
                                        .addAddress(state.address);
                                  } else {
                                    context
                                        .read<AddressCubit>()
                                        .updateAddress(state.address);
                                  }

                                  DialogManagerOverlay.closeDialog();
                                  Navigator.pop(context);
                                } else {
                                  DialogManagerOverlay.closeDialog();
                                }
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: FilledButtonWidget(
                                  onPress: () => onTap(addressModel),
                                  widget: Text(
                                    addressModel == null
                                        ? 'Add Address'
                                        : 'Edit Address',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Future onTap(AddressModel? addressModel) async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final location = context.read<LocationAndGpsCubit>().state;
      var model = AddressRequestModel(
        fullAddress: fullAddressController.text,
        apartment: apartmentController.text,
        floor: floorController.text,
        flatNumber: int.parse(flatController.text),
        additionalInfo: additionalInfoController.text,
        countryId: selectedCountryId,
        cityId: selectedCityId,
        districtId: selectedDistrictId,
        subDistrictId: selectedSubDistrictId,
        lat: addressModel == null ? location.currentLocation?.lat ?? 0 : null,
        lng: addressModel == null ? location.currentLocation?.lng ?? 0 : null,
      );

      await context
          .read<AddEditAddressCubit>()
          .addEditAddress(model, addressModel?.id);
    }
  }
}
