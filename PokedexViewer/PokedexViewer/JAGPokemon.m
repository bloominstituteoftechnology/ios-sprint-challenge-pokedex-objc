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
               andIdentifier:(NSNumber *)anIdentifier
                  withSprite:(NSString *)aSpriteURLString
                andAbilities:(NSArray <NSString *> *)abilities
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
    NSNumber *identifier = dictionary[@"id"];
    NSDictionary *sprites = [dictionary objectForKey:@"sprites"];
    NSString *spriteURLString = sprites[@"front_default"];
    NSArray *abilitiesArray = [dictionary objectForKey:@"abilities"];

    NSMutableArray *newArray = [[NSMutableArray alloc] init];

    for (NSDictionary *abilityObject in abilitiesArray) {
        NSDictionary *ability = [abilityObject  objectForKey:@"ability"];
        NSLog(@"%@", ability);
        NSString *abilityName = ability[@"name"];
        NSLog(@"%@", abilityName);

        [newArray addObject:abilityName];
    }

    self.abilities = newArray.copy;

    return [self initWithName:name andIdentifier:identifier withSprite:spriteURLString andAbilities:self.abilities];
}

@end
