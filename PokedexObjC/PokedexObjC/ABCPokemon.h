//
//  ABCPokemon.h
//  PokedexObjC
//
//  Created by Austin Cole on 3/8/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABCPokemonAbility.h"
#import "ABCPokemonSprite.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABCPokemon : NSObject

@property NSString *name;
@property NSString *url;
@property NSNumber *idNumber;
@property NSArray *abililties;
@property NSString *sprite;

- (instancetype)initNameAndUrlWithDictionary:(NSDictionary *)dictionary;

- (instancetype)fillInDetailsWithDictionary: (NSDictionary *)dictionary withViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
