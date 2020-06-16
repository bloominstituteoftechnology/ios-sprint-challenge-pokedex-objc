//
//  DSCPokemon.h
//  PokedexOBJC
//
//  Created by denis cedeno on 6/12/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSCPokemon : NSObject

@property (nonatomic, nonnull, copy) NSString *name;
@property (nonatomic, nonnull, copy) NSString *pokemonURL;
@property (nonatomic, nonnull, copy) NSString *pokemonID;
@property (nonatomic, nonnull, copy) NSString *spriteURL;
@property (nonatomic, nonnull, copy) NSString *abilities;
@property (nonatomic, nonnull) UIImage *pokemonSprite;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)getAbilityArray:(NSArray *)abilityArray;

@end

NS_ASSUME_NONNULL_END
