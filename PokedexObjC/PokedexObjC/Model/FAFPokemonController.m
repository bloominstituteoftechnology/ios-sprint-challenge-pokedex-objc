//
//  FAFPokemonController.m
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

#import "FAFPokemonController.h"
#import "FAFPokemon.h"
#import "PokedexObjC-Swift.h"

@interface FAFPokemonController ()

    @property (nonatomic, strong, readwrite) NSMutableArray<FAFPokemon *> *internalPokemons;
    
@end

@implementation FAFPokemonController
    
+ (id)sharedInstance {
    static FAFPokemonController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (id)init {
    if (self = [super init]) {
        [[FAFPokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<FAFPokemon *> * pokemons, NSError * error) {
            self->_internalPokemons = [NSMutableArray arrayWithArray:pokemons];
        }];
    }
    return self;
}
    
-(NSArray *)pokemons{
    return [self internalPokemons];
}
    
@end
