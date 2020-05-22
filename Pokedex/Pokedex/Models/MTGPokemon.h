//
//  MTGPokemon.h
//  Pokedex
//
//  Created by Mark Gerrior on 5/22/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTGPokemon : NSObject

@property (nonatomic, readonly, nonnull) NSString *name;
@property (nonatomic, readonly, nonnull) NSURL *detailURL;
@property (nonatomic, readonly, nullable) NSString *identifier;
@property (nonatomic, readonly, nullable) NSURL *imageURL;
@property (nonatomic, readonly, nullable) NSString *abilities;

- (instancetype _Nullable)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
