//
//  HHPokemon.m
//  Pokedex
//
//  Created by Hayden Hastings on 7/26/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

#import "HHPokemon.h"

#define CheckisKindOfClass(_v, _c) if ([(_v) isKindOfClass:[_c class]] == NO) { return nil; }

@implementation HHPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSString *pokeName = dictionary[@"name"];
        CheckisKindOfClass(pokeName, NSString);
        NSNumber *pokeID = dictionary[@"id"];
        
        _pokeName = pokeName;
        _pokeID = pokeID;
        
        NSString *sprite = [dictionary valueForKeyPath:@"sprites.front_default"];
        NSArray *info = dictionary[@"abilities"];
        NSArray *abilityName = [info valueForKeyPath:@"ability.name"];
        
        _pokeAbilities = abilityName;
        _sprite = sprite;
    }
    return self;
}

@end
