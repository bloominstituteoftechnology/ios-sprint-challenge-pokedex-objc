//
//  Pokemon.h
//  Pokedex
//
//  Created by Andrew Liao on 10/12/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AELPokemon : NSObject

-(instancetype) initWithName: (NSString *) name url: (NSString *) url;
-(instancetype) initWithDictionary: (NSDictionary *) dictionary;


@property NSString *name;
@property (nullable) NSString *id;
@property (nullable) NSString *abilities;
@property (nullable) UIImage *sprite;

@property NSString *url;

@end

NS_ASSUME_NONNULL_END
