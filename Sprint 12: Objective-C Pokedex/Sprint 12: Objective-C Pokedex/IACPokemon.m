//
//  IACPokemon.m
//  Sprint 12: Objective-C Pokedex
//
//  Created by Ivan Caldwell on 3/15/19.
//  Copyright © 2019 Ivan Caldwell. All rights reserved.
//

#import "IACPokemon.h"

@implementation IACPokemon

- (instancetype) initPokemonDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _pokemonName = dictionary[@"name"];
        _pokemonID = nil;
        _pokemonAbilities = nil;
        _pokemonFrontDefaultURL = nil;
        NSString *urlString = dictionary[@"url"];
        _pokemonURL = [NSURL URLWithString:urlString];
    }
    return self;
}


- (void) fillInPokemonDictionary:(NSDictionary *)dictionary {
    // Get the pokemon ID
    // Got warning 'NSInteger * _Nonnull' (aka 'long *') from 'id _Nullable'
    // Because I was using NSInteger. Changed NSInteger to NSNumber
    _pokemonID = dictionary[@"id"];
    
    
    // Get the image URL
    NSString *spriteURLString = dictionary[@"sprites"][@"front_default"];
    // Take the string and turn it into a URL
    NSURL *spriteURL = [NSURL URLWithString: spriteURLString];
    _pokemonFrontDefaultURL = spriteURL;
    
    // Get the pokemon abilities
    // Create an empty mutable string arrat to hold all the named abilites
    NSMutableArray<NSString *> *stringAbilities = [[NSMutableArray alloc] init];
    // Get the pokemon abilities dictionary
    NSArray *abilitiesDictionary = dictionary[@"abilities"];

    
    for (NSDictionary *abilityDictionary in abilitiesDictionary) {
        NSString *ability = abilityDictionary[@"ability"][@"name"];
        [stringAbilities addObject: ability];
    }
    // Save abilities to pokemon object
    _pokemonAbilities = stringAbilities;
}

@end
