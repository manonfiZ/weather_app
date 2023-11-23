import 'package:app_weather/core/viewmodel/location_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddLocationDialog extends StatefulWidget {
  const AddLocationDialog({super.key});

  @override
  State<AddLocationDialog> createState() => _AddLocationDialogState();
}

class _AddLocationDialogState extends State<AddLocationDialog> {
  String? _location;

  final _locationKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text("New location"),
      content: TextFormField(
        key: _locationKey,
        onChanged: (value) {
          _location = value;
        },
        validator: (value) => value!.isEmpty ? 'Locality' : null,
        decoration: const InputDecoration(
          label: Text('Name'),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_locationKey.currentState!.validate()) {
              _addLocation(_location!);
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  _addLocation(String location) {
    LocationModel locationModel =
        Provider.of<LocationModel>(context, listen: false);

    locationModel.addNewLocation(location);
    locationModel.updateLocation(location);
  }
}
