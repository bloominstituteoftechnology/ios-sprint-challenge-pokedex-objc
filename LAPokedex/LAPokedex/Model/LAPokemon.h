//
//  LAPokemon.h
//  LAPokedex
//
//  Created by Angel Buenrostro on 4/14/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LAPokemon : NSObject

@property (nonatomic, copy, nonnull) NSString *name;
@property () int identifier;
@property (nonatomic, nullable) NSArray<NSDictionary *> *abilities;
@property (nonatomic, nullable) NSDictionary<NSString *, NSString *> *sprites;

@end

NS_ASSUME_NONNULL_END
