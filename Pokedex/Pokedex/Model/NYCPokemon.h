//
//  NYCPokemon.h
//  Pokedex
//
//  Created by Nathanael Youngren on 4/12/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NYCPokemon : NSObject

- (instancetype)initWithName:(NSString *)name identifier:(NSNumber *_Nullable)identifier spriteURL:(NSURL *_Nullable)spriteURL abilities:(NSArray *_Nullable)abilities detailURL:(NSURL *)detailURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, nullable) NSNumber *identifier;
@property (nonatomic, nullable) NSURL *spriteURL;
@property (nonatomic, nullable) NSArray *abilities;
@property (nonatomic, readonly) NSURL *detailURL;

@end

NS_ASSUME_NONNULL_END
