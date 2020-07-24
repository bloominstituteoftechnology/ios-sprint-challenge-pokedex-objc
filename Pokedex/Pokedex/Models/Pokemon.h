//
//  Pokemon.h
//  Pokedex
//
//  Created by Vincent Hoang on 7/24/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, nullable)NSNumber *identifier;
@property (nonatomic, nullable, copy)NSArray *type;
@property (nonatomic, nullable, copy)NSArray *abilities;
@property (nonatomic, nullable, copy)NSArray *sprite;

@end

NS_ASSUME_NONNULL_END
