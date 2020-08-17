//
//  KRHPokemon.m
//  POKEOBJCDEX
//
//  Created by Kelson Hartle on 8/16/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "KRHPokemon.h"
#import "KRHPokemonAbilities.h"

@implementation KRHPokemon

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSNumber *)identifier
                      sprite:(NSURL *)sprite
              abilitiesArray:(NSArray<NSString *> *)abilitiesArray {
    
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = identifier;
        _image = sprite;
        _abilitiesArray = abilitiesArray;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *name = dictionary[@"name"];
    NSNumber *identifier = dictionary[@"id"];
    
    NSDictionary *sprtiesDictionary = dictionary[@"sprites"];
    NSString *urlString = sprtiesDictionary[@"front_default"];
    NSURL *spriteURL = [NSURL URLWithString:urlString];
    NSArray *abilitiesDictionaries = dictionary[@"abilities"];
    
    NSMutableArray *abilities = [[NSMutableArray alloc] init];
    for (NSDictionary *abilityNameDictionary in abilitiesDictionaries) {
        NSDictionary *abilityDictionary = abilityNameDictionary[@"ability"];
        
        NSString *abilityName = abilityDictionary[@"name"];
        
        if (abilityName) {
            [abilities addObject:abilityName];
        } else {
            NSLog(@"Unable to parse abilities dictionary: %@", abilityNameDictionary);
        }
    }
    
    self = [self initWithName:name identifier:identifier sprite:spriteURL abilitiesArray:abilities];
    return self;
}


@end
