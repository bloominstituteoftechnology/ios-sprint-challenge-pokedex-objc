//
//  BVPokemon.m
//  Pokedex
//
//  Created by brian vilchez on 1/31/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

#import "BVPokemon.h"

@implementation BVPokemon

- (instancetype)initWithName:(NSString *)name sprite:(NSString *)sprite abilities:(NSArray *)abilities {
    self = [super init];
    if (self) {
        _name = name;
        _abilities = abilities;
        _sprite = sprite;
    }
    return self;
}

- (instancetype)initWithResultsName:(NSString *)name  {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}


@end
