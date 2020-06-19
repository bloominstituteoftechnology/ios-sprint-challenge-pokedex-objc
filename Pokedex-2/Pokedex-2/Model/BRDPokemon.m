//
//  BRDPokemon.m
//  Pokedex-2
//
//  Created by Bradley Diroff on 6/19/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

#import "BRDPokemon.h"

@implementation BRDPokemon

- (instancetype)initWithName:(NSString *)name url:(NSString *)url {
    self = [super init];
    if (self) {
        _name = [name copy];
        _url = [url copy];
    }
    return self;
}

@end
