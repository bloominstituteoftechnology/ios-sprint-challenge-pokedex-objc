//
//  JLADetailViewController.m
//  PokedexSprint
//
//  Created by Jorge Alvarez on 3/27/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "JLADetailViewController.h"

@interface JLADetailViewController ()

// MARK: - Outlets

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation JLADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = @"testing";
}

@end
