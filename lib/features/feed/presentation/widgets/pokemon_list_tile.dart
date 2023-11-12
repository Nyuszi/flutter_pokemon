import 'package:flutter/material.dart';
import 'package:flutter_pokemon/core/entities/pokemon.dart';

class PokemonListTile extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;
  final VoidCallback onButtonTap;

  const PokemonListTile({
    Key? key,
    required this.pokemon,
    required this.onTap,
    required this.onButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: pokemon.status ? Colors.amber : Colors.blue,
                  width: 2.0, // Adjust the width of the border as needed
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      pokemon.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      pokemon.type.isEmpty ? '' : pokemon.type.join(', '),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      pokemon.status ? 'Caught' : '-',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return pokemon.status ? Colors.amber : Colors.blue;
                },
              ),
            ),
            onPressed: () {
              onButtonTap();
            },
            child: Text(
              pokemon.status ? 'Release' : 'Catch',
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
