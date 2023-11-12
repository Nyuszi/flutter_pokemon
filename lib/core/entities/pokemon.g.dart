// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonImpl _$$PokemonImplFromJson(Map<String, dynamic> json) =>
    _$PokemonImpl(
      name: json['name'] as String,
      url: json['url'] as String,
      pictureUrl: json['pictureUrl'] as String,
      status: json['status'] as bool,
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      weight: json['weight'] as int,
      height: json['height'] as int,
      abilities:
          (json['abilities'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$PokemonImplToJson(_$PokemonImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'pictureUrl': instance.pictureUrl,
      'status': instance.status,
      'type': instance.type,
      'weight': instance.weight,
      'height': instance.height,
      'abilities': instance.abilities,
    };
