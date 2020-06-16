//
//  JAGPokemon.m
//  PokedexViewer
//
//  Created by Jessie Ann Griffin on 6/12/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import "JAGPokemon.h"

@implementation JAGPokemon

- (instancetype)initWithName:(NSString *)name andURLString:(NSString *)pokemonURLString
{
    if (self = [super init]) {
        _name = name;
        _pokemonURLasString = pokemonURLString;
    }
    return self;
}


- (instancetype)initWithName:(NSString *)aName
               andIdentifier:(NSInteger)anIdentifier
                  withSprite:(NSString *)aSpriteURLString
                andAbilities:(NSMutableArray *)abilities
{
    if (self = [super init]) {
        _name = aName;
        _identifier = anIdentifier;
        _spriteURLString = aSpriteURLString;
        _abilities = abilities;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSInteger identifier = dictionary[@"id"];
    NSDictionary *sprites = [dictionary objectForKey:@"sprites"];
    NSString *spriteURLString = sprites[@"front_default"];
    NSArray *abilitiesArray = [dictionary objectForKey:@"abilities"];

    for (NSDictionary *abilityObject in abilitiesArray) {
        NSDictionary *ability = [abilityObject  objectForKey:@"ability"];
        NSString *abilityName = ability[@"name"];

#pragma mark - This may not be correct with the underscore
        [_abilities addObject:abilityName];
    }


    return [self initWithName:name andIdentifier:identifier withSprite:spriteURLString andAbilities:_abilities];
}

@end
