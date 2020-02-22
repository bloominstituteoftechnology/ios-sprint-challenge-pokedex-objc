//
//  Pokemon.m
//  Pokedex-Objc
//
//  Created by Joel Groomer on 2/22/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

+ (instancetype)fromDictionary:(NSDictionary *)dictionary
{
    if (dictionary[@"name"] && dictionary[@"id"]) {
        int idNumber = (int) dictionary[@"id"];
        Pokemon *newPokemon = [[Pokemon alloc] initWithName:dictionary[@"name"] pokemonID:idNumber];
        
        return newPokemon;
    }
    
    return nil;
}

- (instancetype)initWithName:(NSString *)name pokemonID:(int )idNumber
{
    if (self = [super init]) {
        _name = name;
        _pokemonID = idNumber;
    }
    
    return self;
}

@end
