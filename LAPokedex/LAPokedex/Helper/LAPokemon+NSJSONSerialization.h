//
//  LAPokemon+NSJSONSerialization.h
//  LAPokedex
//
//  Created by Angel Buenrostro on 4/15/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

#import "LAPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface LAPokemon (NSJSONSerialization)

-(nonnull instancetype)initWithName:(nonnull NSString *)name;
-(nonnull instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
