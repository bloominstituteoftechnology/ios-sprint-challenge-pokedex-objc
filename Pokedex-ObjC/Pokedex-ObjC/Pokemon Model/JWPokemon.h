//
//  JWPokemon.h
//  Pokedex-ObjC
//
//  Created by Jerrick Warren on 2/1/19.
//  Copyright © 2019 Jerrick Warren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JWPokemon : NSObject

-(instancetype)initWithName:(NSString *) name
                 identifier:(NSNumber *) identifier
                  abilities:(NSString *) abilities
                     sprite:(NSURL *) sprite;

// make dictionary for Key/Value
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, copy, nullable) NSNumber *identifer; // Int
@property (nonatomic, copy, nullable) NSString *abilities;
@property (nonatomic, copy, nullable) NSURL *sprite; // URL



@end

NS_ASSUME_NONNULL_END
