//
//  PokemonDetail+NSJSONSerialization.m
//  Pokedex
//
//  Created by Bobby Keffury on 2/23/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import "PokemonDetail+NSJSONSerialization.h"
#import "Pokemon.h"

@implementation PokemonDetail (NSJSONSerialization)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *id = dictionary[@"id"];
    NSString *sprite = dictionary[@"front_default"];
    NSArray<NSString *> *abilities = dictionary[@"abilities"];
    
    return [self initWithName:name id:id sprite:sprite abilities:abilities];
}

- (NSDictionary *)toDictionary
{
    NSDictionary *dictionary;
    return dictionary;
}

@end
