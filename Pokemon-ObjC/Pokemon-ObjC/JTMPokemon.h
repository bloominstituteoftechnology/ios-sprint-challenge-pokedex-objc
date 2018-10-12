//
//  JTMPokemon.h
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/12/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JTMPokemon : NSObject

@property NSString *name;
@property NSString *identifier;
@property NSData *sprite;
@property NSArray<NSString *> *abilities;

@end

NS_ASSUME_NONNULL_END
