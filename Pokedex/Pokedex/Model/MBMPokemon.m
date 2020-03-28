//
//  MBMPokemon.m
//  Pokedex
//
//  Created by Michael on 3/27/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import "MBMPokemon.h"

@implementation MBMPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        
        NSString *name = dictionary[@"name"];
        NSString *urlString = dictionary[@"url"];
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        NSNumber *identifier = dictionary[@"id"];
        NSArray<NSString *> *ability = dictionary[@"ability"];
        NSURL *frontImage = dictionary[@"front_image"];
        
        if ([identifier isKindOfClass:[NSNull class]]) {
            identifier = nil;
        }
        
        if ([ability isKindOfClass:[NSNull class]]) {
            ability = nil;
        }
        
        if ([frontImage isKindOfClass:[NSNull class]]) {
            frontImage = nil;
        }
        
        if (!(name || url)) {
            return nil;
        }
        
        _name = name;
        _detailURL = url;
        _identifier = identifier;
        _ability = ability;
        _frontImage = frontImage;
    }
    return self;
}

- (MBMPokemon *)updateWithDictionary:(NSDictionary *)dictionary pokemon:(MBMPokemon *)pokemon {
    
    NSNumber *identifier = dictionary[@"id"];
    NSArray *abilityDictionaries = dictionary[@"abilities"];
    NSMutableArray<NSString *> *abilities = [[NSMutableArray alloc] init];
    
    for (NSDictionary *abilityDict in abilityDictionaries) {
        NSDictionary *abilitities = abilityDict[@"ability"];
        NSString *abilityName = abilitities[@"name"];
        
        if (abilityName) {
            [abilities addObject:abilityName];
        } else {
            NSLog(@"Unable to parse abilities dictionaries: %@", abilityDictionaries);
        }
    }
    
    NSDictionary *sprites = dictionary[@"sprites"];
    NSString *frontImageString = sprites[@"front_default"];
    NSURL *frontImage = [[NSURL alloc] initWithString:frontImageString];
    
    pokemon.identifier = identifier;
    pokemon.ability = abilities;
    pokemon.frontImage = frontImage;
    
    NSLog(@"This is the returned Pokemon: Identifier: %@ Abilities: %@ Image: %@",
          pokemon.identifier, pokemon.ability, pokemon.frontImage);
    
    return pokemon;
}

@end
