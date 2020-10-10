//
//  Pokemon.h
//  Pokedex
//
//  Created by Lambda_School_Loaner_241 on 10/9/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *abilities;
@property (nonatomic, readonly) double number;

- (instancetype)initWithName: (NSString *)pokemonName abilities: (NSString *)pokemonAbilities number: (double) numb;

@end

NS_ASSUME_NONNULL_END
