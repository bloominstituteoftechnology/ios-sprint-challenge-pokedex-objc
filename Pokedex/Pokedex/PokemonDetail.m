//
//  PokemonDetail.m
//  Pokedex
//
//  Created by Bobby Keffury on 2/23/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import "PokemonDetail.h"

@implementation PokemonDetail

- (instancetype)initWithName:(NSString *)name id:(NSString *)id sprite:(NSString *)sprite abilities:(NSArray<NSString *> *)abilities
{
    self = [super init];
    if (self) {
        _name = name;
        _id = id;
        _sprite = sprite;
        _abilities = abilities;
    }
    return self;
}

@end

//Make sure objects are in right format
