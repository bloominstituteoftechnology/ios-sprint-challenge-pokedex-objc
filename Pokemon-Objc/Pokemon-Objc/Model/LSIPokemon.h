//
//  LSIPokemon.h
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSIPokemon : NSObject

@property (nonatomic, nonnull) NSString *name;
@property (nonatomic, nonnull) NSString *urlString;
@property (nonatomic, nullable) NSNumber *identifier;
@property (nonatomic, nullable) NSMutableString *sprite;
@property (nonatomic, nonnull) NSMutableArray<NSString *> *abilities;

- (nonnull instancetype)initWithName:(nonnull NSString *)name url:(nonnull NSString *)urlString;

@end
