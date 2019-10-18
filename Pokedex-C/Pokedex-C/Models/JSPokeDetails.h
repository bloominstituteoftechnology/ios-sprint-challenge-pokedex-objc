//
//  JSPokeDetails.h
//  Pokedex-C
//
//  Created by Jeffrey Santana on 10/18/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(PokeDetails)
@interface JSPokeDetails : NSObject

@property int id;
@property (copy) NSString * name;
@property double height;
@property double weight;
@property UIImage *image;
@property (copy) NSArray<NSString *> * abilities;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
