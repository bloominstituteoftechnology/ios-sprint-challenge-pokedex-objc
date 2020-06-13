//
//  SBAPokemon.m
//  Pokedex
//
//  Created by Sal B Amer on 6/12/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//


#import "SBAPokemon.h"

@implementation SBAPokemon

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (void)setAbilities:(NSArray<NSString *> *)abilities {
    _abilities = [abilities copy];
}

 
@end
