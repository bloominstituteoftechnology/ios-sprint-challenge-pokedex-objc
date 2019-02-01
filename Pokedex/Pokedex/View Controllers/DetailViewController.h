//
//  DetailViewController.h
//  Pokedex
//
//  Created by Nikita Thomas on 2/1/19.
//  Copyright © 2019 Nikita Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKTPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic, weak) NKTPokemon *pokemon;

- (UIColor*) getPixelColorAtLocation:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
