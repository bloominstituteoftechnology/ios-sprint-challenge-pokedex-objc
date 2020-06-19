//
//  HAOPokemon.m
//  Pokedex-Objc
//
//  Created by Hunter Oppel on 6/19/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import "HAOPokemon.h"

@implementation HAOPokemon

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
        _spriteURL = [[NSURL alloc] init];
        _identifier = [[NSNumber alloc] init];
        _abilities = [[NSArray alloc] init];
    }
    return self;
}

- (void)fillInDetailsWithDictionary:(NSDictionary *)dictionary
{    
    NSNumber *identifier = dictionary[@"id"];
    
    NSDictionary *spriteDictionary = dictionary[@"sprites"];
    NSString *spriteURLString = spriteDictionary[@"front_default"];
    NSURL *spriteURL = [[NSURL alloc] initWithString:spriteURLString];
    
    NSArray *abilitiesArray = dictionary[@"abilities"];
    NSMutableArray<NSString *> *abilities = [[NSMutableArray<NSString *> alloc] init];
    
    for (NSDictionary *abilitiesDictionary in abilitiesArray) {
        NSDictionary *abilityDictionary = abilitiesDictionary[@"ability"];
        NSString *abilityName = abilityDictionary[@"name"];
        [abilities addObject:abilityName];
    }
    
    self.spriteURL = spriteURL;
    self.abilities = [abilities copy];
    self.identifier = identifier;
}

@end
