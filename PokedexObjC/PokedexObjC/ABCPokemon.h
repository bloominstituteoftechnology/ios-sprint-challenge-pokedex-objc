//
//  ABCPokemon.h
//  PokedexObjC
//
//  Created by Austin Cole on 3/8/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABCPokemon : NSObject

@property NSString *name;
@property NSString *url;
@property NSString *idNumber;
@property NSArray *abililties;
@property NSString *sprite;

- (instancetype)initNameAndUrlWithDictionary:(NSDictionary *)dictionary;

- (instancetype)fillInDetailsWithDictionary: (NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
