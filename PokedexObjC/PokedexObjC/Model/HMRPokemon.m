//
//  HMRPokemon.m
//  PokedexObjC
//
//  Created by Harmony Radley on 7/24/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

#import "HMRPokemon.h"

@implementation HMRPokemon

- (instancetype)initWithName:(NSString *)name detailURL:(NSString *)detailURL {
    self = [super init];
    if (self) {
        _name = [name copy];
        _detailURL = [detailURL copy];
    }
    return self;
}

@end
