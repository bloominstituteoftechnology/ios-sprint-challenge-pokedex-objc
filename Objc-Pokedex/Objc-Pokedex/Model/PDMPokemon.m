//
//  PDMPokemon.m
//  Objc-Pokedex
//
//  Created by Patrick Millet on 6/19/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import "PDMPokemon.h"
#import "PDMPokemonAbility.h"
#import "PDMPokemonSprite.h"

@interface PDMPokemon ()

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, readwrite) NSInteger identifier;
@property (nonatomic, copy, readwrite, nullable) NSArray<PDMPokemonAbility *> *abilities;
@property (nonatomic, strong, readwrite, nullable) PDMPokemonSprite *sprite;

@end

@implementation PDMPokemon

- (instancetype)initWithName:(NSString *)name
                  identifier:(NSInteger)identifier
                   abilities:(nullable NSArray<PDMPokemonAbility *> *)abilities
                      sprite:(nullable PDMPokemonSprite *)sprite
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _identifier = identifier;
        _abilities = [abilities copy];
        _sprite = sprite;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    if (!name) { return nil; }
    
    NSNumber *identifier = dictionary[@"id"];
    
    NSArray *abilitiesDicts = dictionary[@"abilities"];
    NSMutableArray *abilities = [NSMutableArray array];
    for (NSDictionary *abilitiesDict in abilitiesDicts) {
        PDMPokemonAbility *ability = [[PDMPokemonAbility alloc] initWithDictionary:abilitiesDict];
        [abilities addObject:ability];
    }
    self.abilities = abilities;
    
    NSDictionary *spritesDict = dictionary[@"sprites"];
    PDMPokemonSprite *sprite = [[PDMPokemonSprite alloc] initWithDictionary:spritesDict];
    
    return [self initWithName:name identifier:identifier.integerValue abilities:abilities sprite:sprite];
}

- (void)readFromDictionary:(NSDictionary *)dictionary
{
    PDMPokemon *placeholder = [[PDMPokemon alloc] initWithDictionary:dictionary];
    self.name = placeholder.name;
    self.identifier = placeholder.identifier;
    self.abilities = placeholder.abilities;
    self.sprite = placeholder.sprite;
}

@end
