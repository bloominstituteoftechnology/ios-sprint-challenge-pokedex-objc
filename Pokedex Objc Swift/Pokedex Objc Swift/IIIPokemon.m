//
//  IIIPokemon.m
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import "IIIPokemon.h"

@interface IIIPokemon ()

@property (nonatomic, readwrite, copy) NSString *pokemonName;
@property (nonatomic, readwrite) NSURL *pokemonURL;

@property (nonatomic, readwrite) NSNumber *pokemonID;
@property (nonatomic, nullable, readwrite, copy) NSArray<NSString *> *pokemonAbilities;
@property (nonatomic, nullable, readwrite) NSURL *pokemonFrontDefaultImageURL;

@end

@implementation IIIPokemon

- (instancetype)initPokemonWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _pokemonName = dictionary[@"name"];
        NSString *urlString = dictionary[@"url"];
        _pokemonURL = [NSURL URLWithString:urlString];
        _pokemonID = nil;
        _pokemonAbilities = nil;
        _pokemonFrontDefaultImageURL = nil;
    }
    return self;
}

- (void)updatePokemonWithDictionary:(NSDictionary *)dictionary
{
    _pokemonID = dictionary[@"id"];
    
    NSDictionary *spritesDictionary = dictionary[@"sprites"];
    NSString *urlString = spritesDictionary[@"front_default"];
    _pokemonFrontDefaultImageURL = [NSURL URLWithString:urlString];
    
    NSMutableArray<NSString *> *internalAbilities = [[NSMutableArray alloc] init];
    NSArray *abilities = dictionary[@"abilities"];
    for (NSDictionary *everyDictionary in abilities) {
        NSDictionary *ability = everyDictionary[@"ability"];
        NSString *abilityName = ability[@"name"];
        [internalAbilities addObject:abilityName];
    }
    _pokemonAbilities = internalAbilities;
}

@end
