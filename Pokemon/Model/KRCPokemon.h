//
//  KRCPokemon.h
//  Pokemon
//
//  Created by Christopher Aronson on 7/26/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_SWIFT_NAME(Pokemon)
@interface KRCPokemon : NSObject

@property (nonatomic, nonnull, copy) NSString *name;
@property (nonatomic, nonnull, copy) NSString *infoURL;

@property (nonatomic, nullable, copy) NSString *identifier;
@property (nonatomic, nullable, copy) UIImage *spriteImage;
@property (nonatomic, nullable, copy) NSArray<NSString *> *abilities;

- (instancetype _Nonnull)initWithName:(NSString * _Nonnull)name url:(NSString * _Nonnull)infoURL;

@end
