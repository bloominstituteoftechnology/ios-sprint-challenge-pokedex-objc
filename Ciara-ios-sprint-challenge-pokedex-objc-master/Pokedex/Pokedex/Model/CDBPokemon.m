//
//  CDBPokemon.m
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

#import "CDBPokemon.h"
#import "CDBPokemonAbility.h"
#import "CDBPokemonSprite.h"

@interface CDBPokemon ()

@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readwrite, copy) NSString *url;
@property (nonatomic, readwrite) NSNumber *identifier;
@property (nonatomic, strong, readwrite, nullable) CDBPokemonSprite *sprite;
@property (nonatomic, copy, readwrite, nullable) NSArray<CDBPokemonAbility *> *abilities;

@end

@implementation CDBPokemon

- (instancetype) initWithName:(NSString *)name
                      withURL:(NSString *)url
               withIdentifier:(NSNumber *)identifier
                    abilities:(nullable NSArray<CDBPokemonAbility *> *)abilities
                       sprite:(nullable CDBPokemonSprite *)sprite {
    self = [super init];
    if (self) {
        _name = [name copy];
        _url = url;
        _identifier = identifier;
        _sprite = sprite;
        _abilities = [abilities copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    if (!name) { return nil; }
    
    NSString *url = dictionary[@"url"];
    
    NSNumber *identifier = dictionary[@"id"];
    
    NSArray *abilitiesDicts = dictionary[@"abilities"];
    NSMutableArray *abilities = [NSMutableArray array];
    for (NSDictionary *abilitiesDict in abilitiesDicts) {
        CDBPokemonAbility *ability = [[CDBPokemonAbility alloc] initWithDictionary:abilitiesDict];
        [abilities addObject:ability];
    }
    self.abilities = abilities;
        
    NSDictionary *spritesDict = dictionary[@"sprites"];
    CDBPokemonSprite *sprite = [[CDBPokemonSprite alloc] initWithDictionary:spritesDict];
    return [self initWithName:name withURL:url withIdentifier:identifier abilities:_abilities sprite:sprite];
}

- (void)valuesFromDict:(NSDictionary *)dictionary {
    CDBPokemon *pokemon = [[CDBPokemon alloc] initWithDictionary:dictionary];
    self.name = pokemon.name;
    self.url = pokemon.url;
    self.identifier = pokemon.identifier;
    self.sprite = pokemon.sprite;
    self.abilities = pokemon.abilities;
}

@end
