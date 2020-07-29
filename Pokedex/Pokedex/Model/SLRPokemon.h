//
//  SLRPokemon.h
//  Pokedex
//
//  Created by Sameera Roussi on 7/26/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLRPokemon : NSObject

@property (nonatomic, nullable, copy) NSString *pokemonName;
@property(nonatomic, nullable, copy) NSString *detailLink;

@property(nonatomic, nullable, copy) NSString *sprite;
@property(nonatomic, nullable, copy) NSString *pokemanID;
@property(nonatomic, nullable, copy) NSString *abilities;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
- (instancetype) initWithPokemonName:(NSString *)pokemonName detailLink:(NSString *)detailLink;
-(void) abilitiesArray: (NSArray *) array;

@end

NS_ASSUME_NONNULL_END
