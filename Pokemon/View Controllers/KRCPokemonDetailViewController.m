//
//  KRCPokemonDetailViewController.m
//  Pokemon
//
//  Created by Christopher Aronson on 7/26/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import "KRCPokemonDetailViewController.h"
#import "Pokemon-Swift.h"
#import "KRCPokemon.h"

@interface KRCPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *spriteImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation KRCPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self pokemon] addObserver:self forKeyPath:@"identifier" options:0 context:nil];
    [[self pokemon] addObserver:self forKeyPath:@"spriteImage" options:0 context:nil];
    [[self pokemon] addObserver:self forKeyPath:@"abilities" options:0 context:nil];
    
    [[self nameLabel] setText:[[self pokemon] name]];
    
    [[KRCPokemonAPI sharded] fillInDetailsFor:[self pokemon]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"identifier"]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self idLabel] setText:[[self pokemon] identifier]];
        });
        
    } else if ([keyPath isEqualToString:@"spriteImage"]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self spriteImageView] setImage:[[self pokemon] spriteImage]];
        });

    } else if ([keyPath isEqualToString:@"abilities"]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *abilities = [[[self pokemon] abilities] componentsJoinedByString:@"\n"];
            [[self abilitiesTextView] setText: abilities];
        });
        
    } else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
