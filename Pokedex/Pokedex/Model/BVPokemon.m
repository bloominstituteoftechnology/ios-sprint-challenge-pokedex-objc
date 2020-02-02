//
//  BVPokemon.m
//  Pokedex
//
//  Created by brian vilchez on 1/31/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

#import "BVPokemon.h"

@implementation BVPokemon

- (instancetype)initWithName:(NSString *)name sprite:(NSString *)sprite abilities:(NSArray *)abilities pokemonID:(int)pokemonID{
    self = [super init];
    if (self) {
        _name = name;
        _abilities = abilities;
        _sprite = sprite;
        _pokemonID = pokemonID;
    }
    return self;
}

- (instancetype)initWithResultsName:(NSString *)name  {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *name = dictionary[@"name"];
    int PokemonID = [dictionary[@"id"] intValue];
    NSString *sprites = dictionary[@"sprites"][@"front_default"];
    NSArray *abilitiesArray = dictionary[@"abilities"];
   
    
   return [self initWithName:name sprite:sprites abilities:abilitiesArray pokemonID:PokemonID];
    
}


@end
