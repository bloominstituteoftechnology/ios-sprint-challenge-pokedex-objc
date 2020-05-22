//
//  LYDPokemonController.m
//  LYDPokedexObjc
//
//  Created by Lydia Zhang on 5/22/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

#import "LYDPokemonController.h"


@interface LYDPokemonController()

@property (nonatomic) NSMutableArray<LYDPokemon *> *pokeMutArray;

@end

@implementation LYDPokemonController

- (instancetype)init{
    self = [super init];
    if (self) {
        _pokeMutArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)addPoke:(NSArray<LYDPokemon *> *)pokemon{
    for (LYDPokemon *newPoke in pokemon) {
        [self.pokeMutArray addObject:newPoke];
    }
}

- (NSArray<LYDPokemon *> *)pokemon{
    return [_pokeMutArray copy];
}

@end
