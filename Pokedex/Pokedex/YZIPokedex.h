//
//  YZIPokedex.h
//  Pokedex
//
//  Created by Yvette Zhukovsky on 2/1/19.
//  Copyright © 2019 Yvette Zhukovsky. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage ;
NS_ASSUME_NONNULL_BEGIN

@interface YZIPokedex : NSObject

- (void)updateWithDictionary:(NSDictionary<NSString *, id> *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary<NSString *, NSString *> *)dictionary;


@property (readonly, nullable) NSURL *imagesURL;
@property (readonly, nullable) NSString *identifier;
@property (readonly, nullable) NSString *abilities;
@property NSString *name;
@property (nullable) UIImage *image;
@property NSURL *url;




@end

NS_ASSUME_NONNULL_END
