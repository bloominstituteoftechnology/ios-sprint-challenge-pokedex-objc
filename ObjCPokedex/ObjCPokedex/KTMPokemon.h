//
//  KTMPokemon.h
//  ObjCPokedex
//
//  Created by Kobe McKee on 7/26/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KTMPokemon : NSObject

@property (nonatomic, copy, readwrite)NSString *name;
@property (nonatomic, copy, readwrite, nullable)NSNumber *identifier;
@property (nonatomic, copy, readwrite, nullable)NSArray<NSString *> *abilities;
@property (nonatomic, copy, readwrite, nullable)NSURL *spriteURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
