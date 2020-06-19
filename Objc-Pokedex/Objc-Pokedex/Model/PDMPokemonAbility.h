//
//  PDMPokemonAbility.h
//  Objc-Pokedex
//
//  Created by Patrick Millet on 6/19/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PDMPokemonAbility : NSObject

- (instancetype)initWithName:(NSString *)name;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy, readonly) NSString *name;

@end

NS_ASSUME_NONNULL_END
