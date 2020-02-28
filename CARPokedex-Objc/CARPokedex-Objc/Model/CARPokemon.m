//
//  CARPokemon.m
//  CARPokedex-Objc
//
//  Created by Chad Rutherford on 2/28/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARPokemon.h"

@implementation CARPokemon

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = [name copy];
        _pokemonId = nil;
        _spriteURL = nil;
        _abilities = nil;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    self = [self initWithName:name];
    return self;
}

@end
