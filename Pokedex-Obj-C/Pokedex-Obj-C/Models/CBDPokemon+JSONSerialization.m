//
//  CBDPokemon+JSONSerialization.m
//  Pokedex-Obj-C
//
//  Created by Christopher Devito on 5/22/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "CBDPokemon+JSONSerialization.h"

@implementation CBDPokemon (JSONSerialization)

-(instancetype)initFromDictionary:(NSDictionary *)dictionary {
    NSArray *abilitiesRaw = dictionary[@"abilities"];
    NSMutableArray<NSString *> *abilities = [[NSMutableArray alloc] init];
    for (NSDictionary *abilityDict in abilitiesRaw) {
        NSDictionary *ability = abilityDict[@"ability"];
        NSString *name = ability[@"name"];
        [abilities addObject:name];
    }
    NSString *name = dictionary[@"name"];
    NSNumber *identifier = dictionary[@"id"];
    NSDictionary *sprites = dictionary[@"sprites"];
    NSString *spriteURL = sprites[@"front_default"];

    return [[CBDPokemon alloc] initWithName:name identifier:identifier spriteURL:spriteURL abilities:abilities];
}

@end
