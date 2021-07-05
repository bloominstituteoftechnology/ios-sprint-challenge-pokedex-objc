//
//  ABCPokemonAbility.h
//  PokedexObjC
//
//  Created by Austin Cole on 3/8/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABCPokemonAbility : NSObject

@property NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
