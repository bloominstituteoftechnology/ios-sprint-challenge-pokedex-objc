//
//  MBMSelectedPokemon.h
//  Pokedex
//
//  Created by Michael on 3/27/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBMSelectedPokemon : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSNumber *identifier;
@property (nonatomic, readonly) NSArray *ability;
@property (nonatomic, readonly) NSURL *largeImage;

- (instancetype)initWithName:(NSString *)name
                  identifier:(int)identifier
                     ability:(NSArray *)ability
                  largeImage:(NSURL *)largeImage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
