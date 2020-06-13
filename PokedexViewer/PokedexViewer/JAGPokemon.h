//
//  JAGPokemon.h
//  PokedexViewer
//
//  Created by Jessie Ann Griffin on 6/12/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JAGPokemon : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic) NSInteger identifier;
@property (nonatomic, readonly, copy) NSString *spriteURLString;
@property (nonatomic, readonly, copy) NSArray *abilities;

- (instancetype)initWithName:(NSString *)aName
               andIdentifier:(NSInteger)anIdentifier
                  withSprite:(NSString *)aSpriteURLString
                andAbilities:(NSArray *)abilities;

@end

NS_ASSUME_NONNULL_END
