//
//  WASPokemon.m
//  Pokedex-Objective-C
//
//  Created by Alex Shillingford on 6/14/20.
//  Copyright © 2020 shillwil. All rights reserved.
//

#import "WASPokemon.h"

@implementation WASPokemon

- (instancetype)initWithName:(NSString *)name
                  identifier:(int)identifier
                   abilities:(NSString *)abilities
                  frontImage:(NSURL *)frontImage
{
    if (self = [super init]) {
        _name = name;
        _identifier = identifier;
        _abilities = abilities;
        _frontImage = frontImage;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    
    int identifier = [dictionary[@"id"] intValue];
    
    NSString *sprite = dictionary[@"sprites"][@"front_default"];
    NSURL *frontImage = [NSURL URLWithString:sprite];
    
    NSString *abilities = @"";
    NSArray *abilityDictsArray = dictionary[@"abilities"];
    for (NSDictionary *ability in abilityDictsArray) {
        NSString *abilityName = ability[@"ability"][@"name"];
        abilities = [abilities stringByAppendingString:[NSString stringWithFormat:@"%@, ", abilityName]];
    }
    
    return [self initWithName:name identifier:identifier abilities:abilities frontImage:frontImage];
}

@end
