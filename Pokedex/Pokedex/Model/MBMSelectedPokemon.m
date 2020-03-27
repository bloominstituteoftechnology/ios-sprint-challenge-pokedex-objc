//
//  MBMSelectedPokemon.m
//  Pokedex
//
//  Created by Michael on 3/27/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import "MBMSelectedPokemon.h"

@implementation MBMSelectedPokemon

- (instancetype)initWithName:(NSString *)name
                  identifier:(int)identifier
                     ability:(NSArray *)ability
                  frontImage:(NSURL *)frontImage {
    
    self = [super init];
    if (self) {
        _name = name;
        _identifier = [NSNumber numberWithInt:identifier];
        _ability = ability;
        _frontImage = frontImage;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *name = dictionary[@"name"];
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
    
    self = [self initWithName:name
                   identifier:identifier.intValue
                      ability:abilities
                   frontImage:frontImage];
    
    return self;
}

@end
