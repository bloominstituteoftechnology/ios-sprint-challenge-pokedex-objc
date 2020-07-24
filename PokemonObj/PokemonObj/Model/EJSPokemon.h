//
//  EJSPokemon.h
//  PokemonObj-CSprint
//
//  Created by Enzo Jimenez-Soto on 7/24/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EJSPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSURL *sprite;
@property (nonatomic, copy) NSArray *abilities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
