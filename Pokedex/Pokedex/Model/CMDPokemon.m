//
//  CMDPokemon.m
//  Pokedex
//
//  Created by Chris Dobek on 6/19/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

#import "CMDPokemon.h"

@implementation CMDPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        _urlString = dictionary[@"url"];
        _name = dictionary[@"name"];
    }
    return self;
}
    
    @end
