//
//  LSIPokemon.h
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSIPokemon : NSObject

@property (nonatomic, nonnull) NSString *name;
@property (nonatomic, nullable) NSNumber *identifier;
@property (nonatomic, nullable) NSString *sprite;
@property (nonatomic, nonnull) NSArray<NSString *> *abilities;

@end
