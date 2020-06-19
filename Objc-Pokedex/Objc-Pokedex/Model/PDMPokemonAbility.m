//
//  PDMPokemonAbility.m
//  Objc-Pokedex
//
//  Created by Patrick Millet on 6/19/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import "PDMPokemonAbility.h"

@implementation PDMPokemonAbility

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"ability"][@"name"];
    if (!name) { return nil; }
    return [self initWithName:name];
}

@end
