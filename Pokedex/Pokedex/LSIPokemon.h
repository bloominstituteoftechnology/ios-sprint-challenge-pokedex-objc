//
//  LSIPokemon.h
//  Pokedex
//
//  Created by Enayatullah Naseri on 6/12/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pokemon)
@interface LSIPokemon : NSObject

@property (nonatomic, copy, nonnull)NSString *pokemonName;
@property (nonatomic, copy)NSNumber *pokemonID;
@property (nonatomic, copy)NSString *pokemonAbilities;
@property (nonatomic, copy, nonnull)NSURL *url;
@property (nonatomic, copy)NSData *sprite;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
