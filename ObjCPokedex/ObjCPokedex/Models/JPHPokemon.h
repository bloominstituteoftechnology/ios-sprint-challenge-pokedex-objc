//
//  JPHPokemon.h
//  ObjCPokedex
//
//  Created by Jerry haaser on 1/31/20.
//  Copyright © 2020 Jerry haaser. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JPHPokemon : NSObject

@property (nonatomic, copy, readonly)NSString *name;
@property (nonatomic, copy, readonly)NSArray <NSString *> *abilities;
@property NSNumber *ID;
@property NSURL *sprite;

- (instancetype)initWithName:(NSString *)name abilities:(NSArray <NSString *>*)abilities ID:(NSNumber *)ID sprite:(NSURL *)sprite;

- (instancetype)initWithDictionary:(NSDictionary* )dictionary;

@end


