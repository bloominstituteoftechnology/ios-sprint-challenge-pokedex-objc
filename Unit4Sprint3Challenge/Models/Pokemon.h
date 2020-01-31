//
//  Pokemon.h
//  Unit4Sprint3Challenge
//
//  Created by Jon Bash on 2020-01-31.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Pokemon : NSObject

@property (nonnull, nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) int idNumber;
@property (nullable, nonatomic, readonly) NSURL *spriteURL;
@property (nullable, nonatomic, readonly) UIImage *sprite;

@end
