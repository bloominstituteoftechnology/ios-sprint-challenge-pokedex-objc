//
//  IIIPokemon.m
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIIPokemon.h"

@interface IIIPokemon ()

@property (nonatomic, nullable, readwrite, copy) NSMutableArray<NSString *> *internalAbilities;

@end

@implementation IIIPokemon

- (instancetype)initPokemonWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _pokemonName = dictionary[@"name"];
        _pokemonURL = dictionary[@"url"];
        _pokemonID = nil;
        _pokemonAbilities = nil;
        _pokemonFrontDefaultImageURL = nil;
    }
    return self;
}

- (void)updatePokemonWithDictionary:(NSDictionary *)dictionary
{
    _pokemonID = dictionary[@"id"];
    
    NSDictionary *spritesDictionary = dictionary[@"sprites"];
    _pokemonFrontDefaultImageURL = spritesDictionary[@"front_default"];
    
    NSArray *abilities = dictionary[@"abilities"];
    for (NSDictionary *ability in abilities) {
        NSString *abilityName = ability[@"name"];
        [self.internalAbilities addObject:abilityName];
    }
    _pokemonAbilities = self.internalAbilities;
}

@end
