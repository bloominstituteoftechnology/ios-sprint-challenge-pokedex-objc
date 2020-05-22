//
//  CBDPokemonShort+JSONSerialization.m
//  Pokedex-Obj-C
//
//  Created by Christopher Devito on 5/22/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

#import "CBDPokemonShort+JSONSerialization.h"

@implementation CBDPokemonShort (JSONSerialization)

-(instancetype)initFromDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *url = dictionary[@"url"];

    return [[CBDPokemonShort alloc] initWithName:name url:url];
}

@end
