//
//  Pokemon.h
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(Pokemon)

@interface Pokemon : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSURL *spriteURL;
@property (nonatomic) NSNumber *identifier;
@property (nonatomic) NSArray<NSString *> *abilities;

- (instancetype)initWithName:(NSString *)name;

- (void)fillInDetailsWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
