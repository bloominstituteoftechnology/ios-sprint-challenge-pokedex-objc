//
//  JCSPokemonController.h
//  PokePracticeObjC
//
//  Created by Lambda_School_Loaner_95 on 4/11/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^JCSPokemonControllerCompletionBlock)(NSArray  * _Nullable pokemons, NSError  * _Nullable error);

@class JCSPokemon;

NS_SWIFT_NAME(PokemonController)
NS_ASSUME_NONNULL_BEGIN

@interface JCSPokemonController : NSObject

- (instancetype)init;

@property (nonatomic, readonly) NSArray<JCSPokemon *> *pokemons;

- (void)fetchAllPokemon:(JCSPokemonControllerCompletionBlock)completion;
- (void)fillInDetails:(JCSPokemon *)pokemon;

@end

NS_ASSUME_NONNULL_END
