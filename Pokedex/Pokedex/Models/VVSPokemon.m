//
//  VVSPokemon.m
//  Pokedex
//
//  Created by Vici Shaweddy on 2/22/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import "VVSPokemon.h"

@implementation VVSPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _name = dictionary[@"name"];
        _identifier = dictionary[@"id"];
        
        // getting the abilities
        NSMutableArray *abilities = [[NSMutableArray alloc] init];
        NSArray<NSDictionary *> *abilitiesArray = dictionary[@"abilities"];
        
        for (NSDictionary *ability in abilitiesArray) {
            NSString *name = ability[@"ability"][@"name"];
            [abilities addObject:name];
        }
        
        _abilities = abilities;

        // getting the sprite
        _spriteURL = [dictionary[@"sprites"][@"front_default"] URL];
    }
    return self;
}

@end
