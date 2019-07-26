//
//  SLRPokemon.m
//  Pokedex
//
//  Created by Sameera Roussi on 7/26/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

#import "SLRPokemon.h"

@implementation SLRPokemon

/*
 @property (nonatomic, nullable, copy) NSString *pokemonName;
 @property(nonatomic, nullable, copy) NSURL *detailLink;
 
 @property(nonatomic, nullable, copy) NSURL *spriteLink;
 @property(nonatomic, nullable, copy) NSString *sprite;
 @property(nonatomic, nullable, copy) NSString *spriteID;
 @property(nonatomic, nullable, copy) NSString *listOfAbilities;
 */

// Initialize the model and get list of Pokemon
- (instancetype) initWithPokemonName:(NSString *)pokemonName detailLink:(NSURL *)detailLink {
    if (self = [super init]) {
        self.pokemonName = pokemonName;
        self.detailLink = detailLink;
    }
    return self;
}

// Network results of Pokemon detail network call
//- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
//    
//    
//    return self;
//}


@end
