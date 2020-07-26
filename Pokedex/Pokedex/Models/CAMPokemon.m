//
//  CAMPokemon.m
//  Pokedex
//
//  Created by Cody Morley on 7/24/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import "CAMPokemon.h"

@implementation CAMPokemon

- (instancetype) initWithName:(NSString *)name
                       number:(int)number
                    spriteURL:(NSURL *)spriteURL
                    abilities:(NSArray<NSString *> *)abilities
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _number = number;
        _spriteURL = [spriteURL copy];
        _abilities = [abilities copy];
    }
    return self;
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    //sprites dictionary to get front_default sprite
    NSDictionary *spritesDictionary = dictionary[@"sprites"];
    NSArray *abilitiesArray = dictionary[@"abilities"];
    
    NSString *spriteString = spritesDictionary[@"front_default"];
    
    NSMutableArray *abilityStrings = [NSMutableArray new];
    if (abilitiesArray) {
        for (NSDictionary<NSString *, NSString *> *abilityDictionary in abilitiesArray) {
            NSString *abilityString = abilityDictionary[@"name"];
            if (abilityString) {
                [abilityStrings addObject:abilityString];
            }
        }
    }
    NSString *name = dictionary[@"name"];
    NSNumber *number = dictionary[@"id"];
    NSURL *spriteURL = [NSURL URLWithString:spriteString];
    
    return [self initWithName:name
                       number:[number intValue]
                    spriteURL:spriteURL
                    abilities:abilityStrings];
}

@end
