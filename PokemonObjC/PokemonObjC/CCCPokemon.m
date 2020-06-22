//
//  CCCPokemon.m
//  PokemonObjC
//
//  Created by Ryan Murphy on 7/26/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

#import "CCCPokemon.h"


@implementation CCCPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        NSString *name = dictionary[@"name"];

        NSInteger pokemonID = dictionary[@"id"]; // this error is stupid and makes my id come back funny on my DetailVC
        _name = name;
        _pokemonID = pokemonID;
        
        NSString *sprite = [dictionary valueForKeyPath: @"sprites.front_default"];
        
        NSArray *abilitiesInfo = dictionary[@"abilities"];
        
        NSArray *names = [abilitiesInfo valueForKeyPath:@"ability.name"];
        _abilities = names;
        _sprite = sprite;
    }
    return self;
}

@end
