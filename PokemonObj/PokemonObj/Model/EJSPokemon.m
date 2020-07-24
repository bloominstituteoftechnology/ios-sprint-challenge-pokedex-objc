//
//  EJSPokemon.m
//  PokemonObj-CSprint
//
//  Created by Enzo Jimenez-Soto on 7/24/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import "EJSPokemon.h"

@implementation EJSPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        NSString *name = dictionary[@"name"];
        
        NSNumber *identifier = dictionary[@"id"];
        
        
        NSDictionary *sprites = dictionary[@"sprites"];
        NSString *spriteString = sprites[@"front_default"];
        NSURL *sprite = [NSURL URLWithString:spriteString];
        
        NSMutableArray *abilitiesArray = [[NSMutableArray alloc] init];
        NSArray *abilitiesDictionary = dictionary[@"abilities"];
        for (NSDictionary *abilityDictionary in abilitiesDictionary)
        {
            
            NSDictionary *abilityDict = abilityDictionary[@"ability"];
            NSString *abilityName = [abilityDict[@"name"] capitalizedString];
            
            [abilitiesArray addObject:abilityName];
            
        }
        
        _name = name;
        _identifier = identifier;
        _sprite = sprite;
        _abilities = abilitiesArray;
    }
    return self;
}

@end
