//
//  CCCPokemon.h
//  PokemonObjC
//
//  Created by Ryan Murphy on 7/26/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCCPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger pokemonID;
@property (nonatomic, copy, nullable) NSString *sprite;
@property (nonatomic, copy, nullable) NSArray<NSString *> *abilities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;



@end

NS_ASSUME_NONNULL_END
