//
//  Pokemon.h
//  Pokedex-Objc
//
//  Created by Joel Groomer on 2/22/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Pokemon : NSObject

@property (nonnull, nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly) int pokemonID;
@property (nullable, nonatomic) NSURL *url;
@property (nullable, nonatomic) NSURL *spriteURL;
@property (nullable, nonatomic) UIImage *sprite;
@property (nullable, nonatomic) NSArray *abilities;

+ (instancetype _Nullable )fromDictionary:(NSDictionary * _Nonnull)dictionary;
- (instancetype _Nullable )initWithName:(NSString * _Nonnull)name pokemonID:(int )idNumber;
- (void)updateDetails;

@end
