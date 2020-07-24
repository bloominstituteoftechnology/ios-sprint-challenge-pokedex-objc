//
//  HMRPokemon.m
//  PokedexObjC
//
//  Created by Harmony Radley on 7/24/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

#import "HMRPokemon.h"

@implementation HMRPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _detailURL = dictionary[@"url"];
        _name = dictionary[@"name"];
    }
    return self;
}

@end
