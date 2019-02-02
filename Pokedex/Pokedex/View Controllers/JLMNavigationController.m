//
//  JLMNavigationController.m
//  Pokedex
//
//  Created by Jason Modisett on 2/1/19.
//  Copyright © 2019 Jason Modisett. All rights reserved.
//

#import "JLMNavigationController.h"

@interface JLMNavigationController ()

@end

@implementation JLMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)setup
{
    self.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationBar.layer.shadowRadius = 12;
    self.navigationBar.layer.shadowOpacity = 0.6;
}

@end
