//
//  JACPokemon.h
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 11/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JACPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *identifier;
@property (nullable, nonatomic, copy) NSData *image;
@property (nullable, nonatomic, copy) NSArray<NSString *> *abilities;

- (void)fillInDetailsWithID:(NSNumber *)identifier image:(NSData *)image abilities:(NSArray<NSString *> *)abilities;

@end

NS_ASSUME_NONNULL_END
