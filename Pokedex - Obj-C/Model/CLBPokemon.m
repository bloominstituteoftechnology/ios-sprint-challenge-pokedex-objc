//
//  CLBPokemon.m
//  Pokedex - Obj-C
//
//  Created by Christian Lorenzo on 6/13/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

#import "CLBPokemon.h"

@implementation CLBPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _urlString = dictionary[@"url"];
        _name = dictionary[@"name"];
    }
    return self;
}

@end
