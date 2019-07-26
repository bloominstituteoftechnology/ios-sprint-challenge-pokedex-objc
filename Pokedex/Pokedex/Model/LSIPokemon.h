//
//  LSIPokemon.h
//  Pokedex
//
//  Created by Alex on 7/26/19.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIPokemon : NSObject

- (instancetype) initWithName:(nonnull NSString *)name pokemonUrl:(nonnull NSURL *)pokemonUrl image:(nullable UIImage *)image identifier:(nullable NSString *)identifier abilities:(nullable NSArray<NSString *>*)abilities;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) UIImage *image;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSArray<NSString *> *abilities;
@property (nonatomic, copy) NSURL *pokemonUrl;

@end

NS_ASSUME_NONNULL_END
