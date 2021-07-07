//
//  MUPokemon.m
//  Pokedex
//
//  Created by Moin Uddin on 11/30/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

#import "MUPokemon.h"

@implementation MUPokemon

- (instancetype)initWithName:(NSString *)name pokemonUrl:(NSURL *)pokemonUrl image:(UIImage *)image identifier:(NSString *)identifier abilities:(NSArray<NSString *> *)abilities
{
    self = [super init];
    if (self) {
        _name = [name copy];
        _pokemonUrl = [pokemonUrl copy];
        if (image && identifier && abilities) {
            _image = [image copy];
            _identifier = [identifier copy];
            _abilities = [abilities copy];
        }
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *pokemonStringURL = dictionary[@"url"];
    NSURL *pokemonUrl = [NSURL URLWithString:pokemonStringURL];
    
    return [self initWithName:name pokemonUrl:pokemonUrl image: NULL identifier: NULL abilities: NULL];
}

@end
