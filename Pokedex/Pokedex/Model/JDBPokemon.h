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

@property (nonatomic, readonly) NSNumber *idNumber;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSURL *sprite;

@property (nonatomic, readonly) NSArray<Ability *> *abilities;
@property (nonatomic, readonly) NSArray<JDBPokemon *> *pokemonResults;

//@property (nonatomic, readonly) NSString *speciesName;
//@property (nonatomic, readonly) NSArray<NSString *> *moves;

- (instancetype)initWithJSON:(id)json;

@end

NS_ASSUME_NONNULL_END
