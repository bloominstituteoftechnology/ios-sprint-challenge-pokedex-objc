//
//  IIIPokemon.h
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IIIPokemon : NSObject

@property (nonatomic, readonly, copy) NSString *pokemonName;
@property (nonatomic, readonly) NSURL *pokemonURL;

@property (nonatomic, readonly) NSNumber *pokemonID;
@property (nonatomic, nullable, readonly, copy) NSArray<NSString *> *pokemonAbilities;
@property (nonatomic, nullable, readonly) NSURL *pokemonFrontDefaultImageURL;

- (instancetype)initPokemonWithDictionary:(NSDictionary *)dictionary;
- (void)updatePokemonWithDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
