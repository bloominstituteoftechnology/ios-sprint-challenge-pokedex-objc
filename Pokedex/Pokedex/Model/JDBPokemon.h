//
//  JDBPokemon.h
//  Pokedex
//
//  Created by Madison Waters on 3/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Ability;

@interface JDBPokemon : NSObject


@property (nonatomic) NSString *name;
@property (nonatomic) NSString *url;
@property (nonatomic) NSInteger idNumber;
@property (nonatomic, nullable) NSString *sprite;

//@property (nonatomic, readonly, nullable) NSArray<Ability *> *abilities;
@property (nonatomic, readonly, nullable) NSArray<JDBPokemon *> *pokemonResults;

- (instancetype)initWithDictionary:(NSDictionary *)allDictionary;
//- (instancetype)initWithJSON:(id)json;
//- (instancetype)initDetailsWithJSON:(id)dictionary;

/////
@property (nonatomic, nullable) NSArray<NSString *> *abilities;

@end

NS_ASSUME_NONNULL_END
