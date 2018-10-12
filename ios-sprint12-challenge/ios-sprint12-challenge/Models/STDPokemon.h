//
//  STDPokemon.h
//  ios-sprint12-challenge
//
//  Created by De MicheliStefano on 12.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Pokemon)
@interface STDPokemon : NSObject

- (instancetype)initWithName:(NSString *)name;

@property NSString *name;
@property (nullable) NSString *identifier;
@property NSString *sprite;
@property (nullable) NSArray *abilities;

@end

NS_ASSUME_NONNULL_END
