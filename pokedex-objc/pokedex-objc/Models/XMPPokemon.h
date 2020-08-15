//
//  XMPPokemon.h
//  pokedex-objc
//
//  Created by conner on 8/14/20.
//  Copyright © 2020 conner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMPPokemon : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSUInteger identifier;
@property (nonatomic) NSMutableArray *abilities;
@property (nonatomic) NSString *imageURL;
@property (nonatomic) NSString *url;

-(instancetype)initWithName:(NSString*)name url:(NSString*)url;

@end

NS_ASSUME_NONNULL_END
