//
//  VDRPokemon.h
//  Pokedex2
//
//  Created by Victor  on 7/26/19.
//  Copyright © 2019 Victor . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Pokemon)
@interface VDRPokemon : NSObject

- (instancetype)initWithName:(NSString *)name;

@property NSString *name;
@property (nullable) NSString *identifier;
@property NSString *sprite;
@property (nullable) NSArray *abilities;

@end

NS_ASSUME_NONNULL_END
