//
//  LTBPokemon.h
//  Pokedex
//
//  Created by Linh Bouniol on 10/12/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTBPokemon : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, readonly, copy, nullable) NSArray<NSString *> *abilities;
@property (nonatomic, readonly, nullable) NSURL *spriteURL;

- (instancetype)initWithName:(NSString *)name;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (void)updateWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
