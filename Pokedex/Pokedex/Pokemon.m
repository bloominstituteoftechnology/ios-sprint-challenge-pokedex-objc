//
//  Pokemon.m
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
        _identifier = [[NSNumber alloc] init];
        _abilites = [[NSArray alloc] init];
        _spriteURL = [[NSURL alloc] init];
    }
    return self;
}

- (void) fillInDetailsForPokemon:(NSDictionary *)dictionary
{
    NSNumber *identifier = dictionary[@"id"];
    
    NSArray *abilitiesArray = dictionary[@"abilities"];
    NSMutableArray<NSString *> *abilities = [[NSMutableArray<NSString *> alloc] init];
    
    for (NSDictionary *ability in abilitiesArray) {
        NSDictionary *abilityDictionary = ability[@"ability"];
        NSString *abilityName = abilityDictionary[@"name"];
        [abilities addObject:abilityName];
    }
    
    NSDictionary *spriteDictionary = dictionary[@"sprites"];
    NSString *spriteURLString = spriteDictionary[@"cfront_default"];
    NSURL *spriteURL = [[NSURL alloc] initWithString:spriteURLString];
    
    self.identifier = identifier;
    self.abilites = [abilities copy];
    self.spriteURL = spriteURL;
}

@end
