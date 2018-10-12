//
//  DODPokemonController.m
//  Sprint12
//
//  Created by David Doswell on 10/12/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import "DODPokemonController.h"
#import "DODPokemon.h"

static NSString * const baseURL = @"https://pokeapi.co/api/v2/pokemon";

@implementation DODPokemonController

- (void)fetchPokemonWithName:(NSString *)name completion:(void (^)(DODPokemon * _Nullable, NSError * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURL];
    baseURL = [baseURL URLByAppendingPathComponent:name];
    
}

@end
