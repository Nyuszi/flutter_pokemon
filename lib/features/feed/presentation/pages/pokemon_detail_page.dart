import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemon/core/entities/pokemon.dart';
import 'package:flutter_pokemon/features/feed/presentation/widgets/custom_appbar.dart';
import 'package:responsive_builder/responsive_builder.dart';

@RoutePage()
class PokemonDetailPage extends StatelessWidget {
  final int id;
  final Pokemon pokemon;
  final VoidCallback onButtonTap;
  const PokemonDetailPage({
    super.key,
    @PathParam('id') required this.id,
    required this.pokemon,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Scaffold(
        appBar: CustomAppBar(
          onPressed: () {
            AutoRouter.of(context).back();
          },
          navigateBack: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: sizingInformation.isMobile
              ? Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: pokemon.status ? Colors.green : Colors.red,
                          width: 4, // Adjust the width as needed
                        ),
                      ),
                      child: Image.network(
                        pokemon.pictureUrl,
                        width: 400,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: Column(
                        children: [
                          _buildInfoRow("Name", pokemon.name,
                              backgroundColor: Colors.grey.shade100),
                          _buildInfoRow("Weight", pokemon.weight.toString(),
                              backgroundColor: Colors.amber.shade100),
                          _buildInfoRow("Height", pokemon.height.toString(),
                              backgroundColor: Colors.grey),
                          _buildInfoRow(
                              "Abilities", pokemon.abilities.join('\n'),
                              backgroundColor: Colors.amber.shade100),
                          _buildInfoRow(
                            "Status",
                            pokemon.status ? 'Caught' : '-',
                            backgroundColor:
                                pokemon.status ? Colors.green : Colors.red,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
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
                    ),
                  ],
                )
              : Row(
                  children: [
                    Column(
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              AutoRouter.of(context).back();
                            },
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Back to search')),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: pokemon.status ? Colors.green : Colors.red,
                              width: 4, // Adjust the width as needed
                            ),
                          ),
                          child: Image.network(
                            pokemon.pictureUrl,
                            width: 400,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 50),
                    Column(
                      children: [
                        const SizedBox(height: 50),
                        _buildInfoRow("Name", pokemon.name,
                            backgroundColor: Colors.grey.shade100),
                        _buildInfoRow("Weight", pokemon.weight.toString(),
                            backgroundColor: Colors.amber.shade100),
                        _buildInfoRow("Height", pokemon.height.toString(),
                            backgroundColor: Colors.grey),
                        _buildInfoRow("Abilities", pokemon.abilities.join('\n'),
                            backgroundColor: Colors.amber.shade100),
                        _buildInfoRow(
                          "Status",
                          pokemon.status ? 'Caught' : '-',
                          backgroundColor:
                              pokemon.status ? Colors.green : Colors.red,
                          textColor: Colors.white,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                return pokemon.status
                                    ? Colors.amber
                                    : Colors.green;
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
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      );
    });
  }
}

Widget _buildInfoRow(
  String label,
  String value, {
  Color? backgroundColor,
  Color? textColor,
}) {
  return Container(
    width: 400,
    color: backgroundColor ?? Colors.transparent,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor ?? Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(color: textColor ?? Colors.black),
        ),
      ],
    ),
  );
}
