//
//  JBPokemon.h
//  Unit4Sprint3Challenge
//
//  Created by Jon Bash on 2020-01-31.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_SWIFT_NAME(Pokemon)
@interface JBPokemon : NSObject

@property (nonnull, nonatomic, readonly) NSString *name;
@property (nonnull, nonatomic, readonly) NSURL *detailURL;
@property (nullable, nonatomic) NSNumber *idNumber;
@property (nullable, nonatomic) NSURL *spriteURL;
@property (nullable, nonatomic) UIImage *sprite;
@property (nullable, nonatomic) NSArray<NSString *> *abilities;

- (instancetype _Nonnull)initWithName:(NSString *_Nonnull)name
                            detailURL:(NSURL *_Nonnull)detailURL;
- (instancetype _Nullable)initWithDictionary:(NSDictionary *_Nonnull)dictionary;

@end
