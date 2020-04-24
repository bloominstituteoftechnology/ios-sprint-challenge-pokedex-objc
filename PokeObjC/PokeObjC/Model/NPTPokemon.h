//
//  NPTPokemon.h
//  PokeObjC
//
//  Created by Nick Nguyen on 4/24/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NPTPokemon : NSObject

@property (nonatomic, copy, readonly )NSString *name;
@property (nonatomic, readwrite)NSNumber *identifier;
@property (nonatomic, readwrite)UIImage *pokemonImage;
@property (nonatomic, readwrite, copy)NSArray *abilities;


- (instancetype)initWithName:(NSString *)name;

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
