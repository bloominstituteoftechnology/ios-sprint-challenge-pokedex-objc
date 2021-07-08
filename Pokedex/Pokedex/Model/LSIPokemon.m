//
//  LSIPokemon.m
//  Pokedex
//
//  Created by Alex on 7/26/19.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "LSIPokemon.h"

@implementation LSIPokemon

- (instancetype)initWithName:(NSString *)name pokemonUrl:(NSURL *)pokemonUrl image:(UIImage *)image identifier:(NSString *)identifier abilities:(NSArray<NSString *> *)abilities {
    if (self = [super init]) {
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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *name = dictionary[@"name"];
    NSString *myPokeUrl = dictionary[@"url"];
    NSURL *pokemonUrl = [NSURL URLWithString:myPokeUrl];
    
    return [self initWithName:name pokemonUrl:pokemonUrl image: NULL identifier: NULL abilities: NULL];
}


@end
