//
//  HAOPokemon.m
//  Pokedex-Objc
//
//  Created by Hunter Oppel on 6/19/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

#import "HAOPokemon.h"

@implementation HAOPokemon

- (instancetype)initWithName:(NSString *)name spriteURL:(NSURL *)spriteURL identifier:(NSString *)identifer abilities:(NSArray<NSString *> *)abilites
{
    self = [super init];
    if (self) {
        _name = name;
        _spriteURL = spriteURL;
        _identifier = identifer;
        _abilites = abilites;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *identifier = dictionary[@"id"];
    
    NSDictionary *spriteDictionary = dictionary[@"sprites"];
    NSString *spriteURLString = spriteDictionary[@"front_default"];
    NSURL *spriteURL = [[NSURL alloc] initWithString:spriteURLString];
    
    NSArray *abilitiesArray = dictionary[@"abilities"];
    NSMutableArray<NSString *> *abilities = [[NSMutableArray<NSString *> alloc] init];
    
    for (NSDictionary *ability in abilitiesArray) {
        NSString *abilityName = ability[@"name"];
        [abilities addObject:abilityName];
    }
    
    self = [self initWithName:name spriteURL:spriteURL identifier:identifier abilities:abilities];
    return self;
}

@end
