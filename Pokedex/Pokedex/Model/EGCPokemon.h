//
//  EGCPokemon.h
//  Pokedex
//
//  Created by Enrique Gongora on 4/24/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EGCPokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray<NSString *> *abilities;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSURL *spriteURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
