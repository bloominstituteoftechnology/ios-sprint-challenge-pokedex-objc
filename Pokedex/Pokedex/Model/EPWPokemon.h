//
//  EPWPokemon.h
//  Pokedex
//
//  Created by Elizabeth Wingate on 4/24/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPWPokemon : NSObject

@property (nonatomic,copy,nonnull)NSString *name;
@property (nonatomic,copy,nonnull)NSURL *url;
@property (nonatomic) int identifier;
@property (nonatomic,nonnull)NSURL *imageURL;
@property (nonatomic,copy,nonnull)NSMutableArray *abilities;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
