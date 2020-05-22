//
//  Pokemon.h
//  Pokedex
//
//  Created by Shawn Gee on 5/22/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, readonly) int identifier;
@property (nonatomic) NSURL *spriteURL;
@property (nonatomic, copy) NSArray<NSString *> *abilities;

- (instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

//pokemon name, identifier, sprite, and abilities
