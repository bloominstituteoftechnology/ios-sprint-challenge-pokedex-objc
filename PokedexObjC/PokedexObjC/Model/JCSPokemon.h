//
//  JCSPokemon.h
//  PokePracticeObjC
//
//  Created by Lambda_School_Loaner_95 on 4/11/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCSPokemon : NSObject

- (instancetype)initWithName:(NSString *)name abilities:(NSArray *)abilities identifier:(NSInteger)identifier photo:(NSString *)photoURL;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithURL:(NSString *)pokemonURL name:(NSString *)name;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy, readonly) NSArray *abilities;
@property (nonatomic) NSInteger identifier;
@property (nonatomic, copy) NSString *photoURL;
@property (nonatomic, copy) NSString *pokemonURL;
@property (nonatomic) BOOL isFilled;

@end

NS_ASSUME_NONNULL_END
