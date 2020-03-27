//
//  JLADetailViewController.m
//  PokedexSprint
//
//  Created by Jorge Alvarez on 3/27/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "JLADetailViewController.h"
#import "JLAPokemon.h"
#import "PokedexSprint-Swift.h"

@interface JLADetailViewController ()

// MARK: - Outlets

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation JLADetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
    self.textView.text = @"testing";
}

- (void)updateViews {
    
    NSLog(@"updateViews");
    
    if (!self.isViewLoaded) {return;}
    
    if (self.pokemon) {
    
        self.title = self.pokemon.name;
    }
}

@end
