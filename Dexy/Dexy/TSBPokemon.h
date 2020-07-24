//
//  TSBPokemon.h
//  Dexy
//
//  Created by Thomas Sabino-Benowitz on 7/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSBPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray<NSString *> *abilities;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSURL *sprite;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
