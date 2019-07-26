//
//  KRCPokemonDetailViewController.m
//  Pokemon
//
//  Created by Christopher Aronson on 7/26/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

#import "KRCPokemonDetailViewController.h"
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
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"identifier"]) {
        
        NSLog(@"identifier has changed");
    } else if ([keyPath isEqualToString:@"spriteImage"]) {
        
        NSLog(@"spriteImage has changed");
    } else if ([keyPath isEqualToString:@"abilities"]) {
        
        NSLog(@"abilities has changed");
    } else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
