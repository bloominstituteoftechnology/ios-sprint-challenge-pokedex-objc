//
//  JDKPokemon.h
//  PokedexHybrid
//
//  Created by John Kouris on 2/22/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pokemon)
@interface JDKPokemon : NSObject

@property (nonatomic, copy, nonnull)NSString *pokemonName;
@property (nonatomic, copy, nonnull)NSURL *url;
@property (nonatomic, copy)NSNumber *pokemonID;
@property (nonatomic, copy)NSString *pokemonAbilities;
@property (nonatomic, copy)NSData *sprite;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
