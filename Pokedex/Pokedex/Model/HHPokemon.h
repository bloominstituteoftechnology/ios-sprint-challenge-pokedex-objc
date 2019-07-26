//
//  HHPokemon.h
//  Pokedex
//
//  Created by Hayden Hastings on 7/26/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHPokemon : NSObject

@property (nonatomic, copy) NSString *pokeName;
@property (nonatomic) NSNumber *pokeID;
@property (nonatomic, copy, nullable) NSString *sprite;
@property (nonatomic, copy, nullable) NSArray<NSString *> *pokeAbilities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
