//
//  MTGPokemon.h
//  Pokedex
//
//  Created by Mark Gerrior on 5/22/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTGPokemon : NSObject

@property (nonatomic, readonly, nonnull) NSString *name;
@property (nonatomic, readonly, nonnull) NSURL *detailURL;
@property (nonatomic, nullable) NSString *identifier;

@property (nonatomic, nullable) NSURL *imageURL;
@property (nonatomic, nullable) UIImage *image;

@property (nonatomic, nullable) NSArray<NSString *> *abilities;

- (instancetype _Nullable)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
