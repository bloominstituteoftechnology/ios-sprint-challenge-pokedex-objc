//
//  HAOPokemon.m
//  Pokedex-Objc
//
//  Created by Hunter Oppel on 6/19/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import "HAOPokemon.h"

@implementation HAOPokemon

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
        _spriteURL = [[NSURL alloc] init];
        _identifier = [[NSString alloc] init];
        _abilites = [[NSArray alloc] init];
    }
    return self;
}

- (void)fillInDetailsForPokemon:(HAOPokemon *)pokemon dictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *identifier = dictionary[@"id"];
    
    NSDictionary *spriteDictionary = dictionary[@"sprites"];
    NSString *spriteURLString = spriteDictionary[@"front_default"];
    NSURL *spriteURL = [[NSURL alloc] initWithString:spriteURLString];
    
    NSArray *abilitiesArray = dictionary[@"abilities"];
    NSMutableArray<NSString *> *abilities = [[NSMutableArray<NSString *> alloc] init];
    
    for (NSDictionary *ability in abilitiesArray) {
        NSString *abilityName = ability[@"name"];
        [abilities addObject:abilityName];
    }
    
    pokemon.name = name;
    pokemon.identifier = identifier;
    pokemon.spriteURL = spriteURL;
    pokemon.abilites = abilities;
}

@end
