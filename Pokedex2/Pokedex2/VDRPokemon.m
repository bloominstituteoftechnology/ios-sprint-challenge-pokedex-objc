//
//  VDRPokemon.m
//  Pokedex2
//
//  Created by Victor  on 7/26/19.
//  Copyright © 2019 Victor . All rights reserved.
//


#import "VDRPokemon.h"

@implementation VDRPokemon

- (instancetype)initWithName:(NSString *)name;
{
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

@end
