//
//  CDGPokemon.m
//  PokemonObjC
//
//  Created by Chris Gonzales on 4/24/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

#import "CDGPokemon.h"

@implementation CDGPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _urlString = dictionary[@"url"];
        _name = dictionary[@"name"];
    }
    return self;
}

@end
