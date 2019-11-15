//
//  CDBPokemonController.m
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

#import "CDBPokemonController.h"
#import "CDBPokemon.h"

@interface CDBPokemonController ()

@property (nonatomic) NSMutableArray <CDBPokemon *> *internalPokemons;

@end

@implementation CDBPokemonController

- (instancetype)init {
    self = [super init];
    if (self) {
        _internalPokemons = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray<CDBPokemon *> *)pokemons {
    return [self.internalPokemons copy];
}

@end
