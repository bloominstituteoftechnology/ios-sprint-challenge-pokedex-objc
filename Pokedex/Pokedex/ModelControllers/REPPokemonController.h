//
//  REPPokemonController.h
//  Pokedex
//
//  Created by Michael Redig on 10/18/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
@class REPPokeman;

NS_ASSUME_NONNULL_BEGIN


@interface REPPokemonController : NSObject
typedef void (^REPLoadCompletionBlock)(NSError *_Nullable);

@property (nonatomic) NSArray<REPPokeman *> *pokemans;

- (instancetype)initWithLoadCompletionHandler:(REPLoadCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
