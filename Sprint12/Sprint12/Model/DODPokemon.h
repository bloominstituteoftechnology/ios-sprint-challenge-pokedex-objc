//
//  DODPokemon.h
//  Sprint12
//
//  Created by David Doswell on 10/12/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DODPokemon : NSObject

// Your model must support at least: pokemon name, identifier, sprite, and abilities.

@property (nonatomic, readonly) NSData *image;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *sprite;
@property (nonatomic, readonly) NSString *abilities;

- (instancetype)initWithName:(NSString *)name identifier:(NSString *)identifier sprite:(NSString *)sprite abilities:(NSString *)abilities;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
