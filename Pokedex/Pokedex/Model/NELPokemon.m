//
//  NELPokemon.m
//  Pokedex
//
//  Created by Nelson Gonzalez on 4/5/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

#import "NELPokemon.h"

#define CheckisKindOfClass(_v, _c) if ([(_v) isKindOfClass:[_c class]] == NO) { return nil; }



@implementation NELPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        NSString *pokeName = dictionary[@"name"];
        CheckisKindOfClass(pokeName, NSString);
        NSNumber *pokeId = dictionary[@"id"];
        
        _pokeName = pokeName;
        _pokeId = pokeId;
        
        NSString *sprite = [dictionary valueForKeyPath:@"sprites.front_default"];
        NSArray *info = dictionary[@"abilities"];
        NSArray *abilityName = [info valueForKeyPath:@"ability.name"];
        
        _pokeAbilities = abilityName;
        _sprite = sprite;

    }
    return self;
}


@end

