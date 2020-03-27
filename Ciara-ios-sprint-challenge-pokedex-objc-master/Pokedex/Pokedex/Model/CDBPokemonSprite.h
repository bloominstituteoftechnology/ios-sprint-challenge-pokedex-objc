//
//  CDBPokemonSprite.h
//  Pokedex
//
//  Created by Ciara Beitel on 3/27/20.
//  Copyright © 2020 Ciara Beitel. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDBPokemonSprite : NSObject

- (instancetype)initWithImageURL:(NSURL *)imageURL;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong, readonly) NSURL *imageURL;

@property (nonatomic, strong, nullable) UIImage *image;

@end

NS_ASSUME_NONNULL_END
