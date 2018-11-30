//
//  IIIPokemon.m
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIIPokemon.h"

@interface IIIPokemon ()

@end

@implementation IIIPokemon

- (instancetype)initPokemonWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _pokemonName = dictionary[@"name"];
        _pokemonURLString = dictionary[@"url"];
        _pokemonID = nil;
        _pokemonAbilities = nil;
        _pokemonFrontDefaultImageURLString = nil;
    }
    return self;
}

- (void)updatePokemonWithDictionary:(NSDictionary *)dictionary
{
    _pokemonID = dictionary[@"id"];
    
    NSDictionary *spritesDictionary = dictionary[@"sprites"];
    _pokemonFrontDefaultImageURLString = spritesDictionary[@"front_default"];
    
    NSMutableArray<NSString *> *internalAbilities = [[NSMutableArray alloc] init];
    NSArray *abilities = dictionary[@"abilities"];
    for (NSDictionary *everyAbility in abilities) {
        NSDictionary *ability = everyAbility[@"ability"];
        NSString *abilityName = ability[@"name"];
        [internalAbilities addObject:abilityName];
    }
    _pokemonAbilities = internalAbilities;
}

@end
