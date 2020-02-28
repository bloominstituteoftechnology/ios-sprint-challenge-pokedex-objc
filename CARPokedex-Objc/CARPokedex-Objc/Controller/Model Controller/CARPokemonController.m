//
//  CARPokemonController.m
//  CARPokedex-Objc
//
//  Created by Chad Rutherford on 2/28/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARPokemonController.h"

@interface CARPokemonController ()

@property (nonatomic) NSMutableArray<CARPokemon*> *internalPokemon;

@end

@implementation CARPokemonController

- (instancetype)init{
    self = [super init];
    if (self) {
        _internalPokemon = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addPokemonFromArray:(NSArray<CARPokemon*> *_Nonnull)pokemon {
    for (CARPokemon *pokemonToAdd in pokemon) {
        [self.internalPokemon addObject:pokemonToAdd];
    }
}

- (NSArray<CARPokemon*> *)pokemon {
    return [_internalPokemon copy];
}
@end
