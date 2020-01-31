//
//  DMOPokemon.m
//  Week15SprintChallenge
//
//  Created by morse on 1/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import "DMOPokemon.h"

@implementation DMOPokemon

- (nonnull instancetype)initWithName:(NSString *)name
                             infoURL:(NSURL *)infoURL
                          identifier:(int)identifier
                           abilities:(NSString *)abilities
                              sprite:(NSURL *)sprite {
    self = [super init];
    if (self) {
        _name = name;
        _infoURL = infoURL;
        _idenitifier = identifier;
        _abilities = abilities;
        _sprite = sprite;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary {
    
    NSString *name = dictionary[@"name"];
    
    NSString *urlString = dictionary[@"url"];
    NSURL *url = [NSURL URLWithString:urlString];
    int identifier = [dictionary[@"id"] intValue];
    
    NSString *spriteString = dictionary[@"sprites"][@"front_default"];
    NSURL *sprite = [NSURL URLWithString:spriteString];
    
    NSString *abilities = @"";
    NSArray *abilityDictionaries = dictionary[@"abilities"];
    for (NSDictionary *abilityDictionary in abilityDictionaries) {
        
        NSString *ability = abilityDictionary[@"ability"][@"name"];
        abilities = [abilities stringByAppendingString:[NSString stringWithFormat:@"%@\n", ability]];
    }
    
    return [self initWithName:name infoURL:url identifier:identifier abilities:abilities sprite:sprite];
}

@end
