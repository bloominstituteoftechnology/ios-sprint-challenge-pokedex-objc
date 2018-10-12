//
//  STDPokemon.m
//  ios-sprint12-challenge
//
//  Created by De MicheliStefano on 12.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

#import "STDPokemon.h"

@implementation STDPokemon

- (instancetype)initWithName:(NSString *)name;
{
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

@end
