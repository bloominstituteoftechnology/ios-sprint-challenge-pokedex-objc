//
//  Pokemon.m
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
        _identifier = [[NSString alloc] init];
        _abilites = [[NSArray alloc] init];
        _spriteURL = [[NSURL alloc] init];
    }
    return self;
}

- (void) fillInDetailsForPokemon:(Pokemon *)pokemon dictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *identifier = dictionary[@"id"];
    
    NSArray *abilitiesArray = dictionary[@"abilities"];
    NSMutableArray<NSString *> *abilities = [[NSMutableArray<NSString *> alloc] init];
    
    for (NSDictionary *ability in abilitiesArray) {
        NSString *abilityName = ability[@"name"];
        [abilities addObject:abilityName];
    }
    
    NSDictionary *spriteDictionary = dictionary[@"sprites"];
    NSString *spriteURLString = spriteDictionary[@"cfront_default"];
    NSURL *spriteURL = [[NSURL alloc] initWithString:spriteURLString];
    
    pokemon.name = name;
    pokemon.identifier = identifier;
    pokemon.abilites = abilities;
    pokemon.spriteURL = spriteURL;
}

@end
