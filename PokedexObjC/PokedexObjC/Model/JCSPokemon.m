//
//  JCSPokemon.m
//  PokePracticeObjC
//
//  Created by Lambda_School_Loaner_95 on 4/11/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import "JCSPokemon.h"

@implementation JCSPokemon

- (instancetype)initWithURL:(NSURL *)pokemonURL name:(NSString *)name {
    self = [super init];
    if (self) {
        _pokemonURL = pokemonURL;
        _name = name;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name abilities:(NSArray *)abilities identifier:(NSInteger)identifier photo:(NSURL *)photoURL {
    self = [super init];
    if (self) {
        _name = name;
        _abilities = abilities;
        _identifier = identifier;
        _photoURL = photoURL;
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSDictionary *speciesDict = dictionary[@"species"];
    
    NSString *name = speciesDict[@"name"];
    NSObject *idObject = dictionary[@"id"];
    NSInteger identifier = -1;
    
    if ([idObject isKindOfClass: [NSNumber class]]) {
        NSNumber *idNumber = (NSNumber *)idObject;
        identifier = [idNumber integerValue];
    } else if ([idObject isKindOfClass: [NSString class]]) {
        NSString *idString = (NSString *)idObject;
        identifier = [idString integerValue];
    }

    
    NSDictionary *spritesDict = dictionary[@"sprites"];
    NSURL *photo = spritesDict[@"back_default"];
    
    NSArray *abilitiesArray = dictionary[@"abilities"];
    NSMutableArray *abilityNames = [[NSMutableArray alloc] init];
    
    for (NSDictionary *ab in abilitiesArray) {
        NSDictionary *abilityDict = ab[@"ability"];
        NSString *abilityName = abilityDict[@"name"];
        [abilityNames addObject:abilityName];
    }
  
    return [self initWithName:name abilities:abilityNames identifier:identifier photo:photo];
    
}



@end
