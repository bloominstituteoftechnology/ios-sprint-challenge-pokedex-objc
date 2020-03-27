//
//  CDBPokemonAbility.h
//  Pokedex
//
//  Created by Ciara Beitel on 3/27/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBPokemonAbility : NSObject

- (instancetype)initWithName:(NSString *)name;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
