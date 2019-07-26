//
//  MRFPokemon.h
//  PokeDexObjc
//
//  Created by Michael Flowers on 7/26/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRFPokemon : NSObject
@property (atomic, readonly, nonnull) NSString *name;
@property (atomic, readonly) int identifier;
@property (atomic, readonly, nonnull) NSString *sprite;
@property (atomic, readonly, nonnull) NSArray< NSString *> *abilities;

- (nonnull instancetype)initWithName:(NSString *_Nonnull)name
                          identifier:(int)identifier
                              sprite:(NSString *_Nonnull)sprite
                           abilities:(NSArray *_Nonnull)abilities;

- (nullable instancetype)initWithDictionary:(NSDictionary *_Nullable)dictionary;

@end

NS_ASSUME_NONNULL_END
