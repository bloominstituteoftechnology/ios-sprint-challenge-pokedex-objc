//
//  SMFPokemon.h
//  Pokedex ObjC
//
//  Created by Samantha Gatt on 10/12/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

NS_ASSUME_NONNULL_BEGIN

@interface SMFPokemon : NSObject

- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSString *> *)dictionary;

@property NSString *name;
@property NSURL *url;
@property (readonly, nullable) NSURL *imageURL;
@property (nullable) UIImage *image;
@property (readonly, nullable) NSString *identifier;
@property (readonly, nullable) NSString *abilities;

- (void)updateWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
