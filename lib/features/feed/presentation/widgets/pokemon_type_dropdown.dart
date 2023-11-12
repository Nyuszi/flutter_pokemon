import 'package:flutter/material.dart';
import 'package:flutter_pokemon/core/entities/pokemon_type.dart';

class PokemonTypeDropdown extends StatelessWidget {
  final List<PokemonType> types;
  final PokemonType? selectedType;
  final Function(PokemonType? selectedType) selectType;

  const PokemonTypeDropdown(
      {super.key,
      required this.types,
      required this.selectedType,
      required this.selectType});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<PokemonType>(
      value: selectedType,
      items: types.map((type) {
        return DropdownMenuItem<PokemonType>(
          value: type,
          child: Text(type.name),
        );
      }).toList(),
      onChanged: (selectedType) {
        selectType(selectedType);
      },
      decoration: const InputDecoration(
        labelText: 'Select a Pokemon Type',
        border: OutlineInputBorder(),
      ),
      hint: selectedType != null
          ? Text(selectedType!.name)
          : const Text('Select a Pokemon Type'),
    );
  }
}
