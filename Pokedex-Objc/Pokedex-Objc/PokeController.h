//
//  PokeController.h
//  Pokedex-Objc
//
//  Created by Joel Groomer on 2/22/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Pokemon;
@class UIImage;

NS_ASSUME_NONNULL_BEGIN

@interface PokeController : NSObject

@property (nullable, nonatomic) NSArray *pokemonList;

- (void)catchEmAll:(void (^)(NSArray * _Nullable, NSError * _Nullable))completion;
- (void)fetchPokemonByName:(NSString *)name withCompletion:(void (^)(Pokemon *))completion;
- (void)fetchPokemonByID:(int)idNumber withCompletion:(void (^)(Pokemon *))completion;
- (void)getImageForPokemon:(Pokemon *)pokemon withCompletion:(void (^)(UIImage *))completion;

@end

NS_ASSUME_NONNULL_END
