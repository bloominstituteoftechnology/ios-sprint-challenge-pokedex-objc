//
//  STDPokemonDetailViewController.m
//  ios-sprint12-challenge
//
//  Created by De MicheliStefano on 12.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

#import "STDPokemonDetailViewController.h"

@interface STDPokemonDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *identifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@property UIImage *image;

- (void)updateViews;

@end

@implementation STDPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokemon addObserver:self forKeyPath:@"identifier" options:0 context:NULL];
    
    if (self.pokemon.identifier != NULL) {
        [self updateViews];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self updateViews];
    });
    NSLog(@"Pokemon with id %@ has updated", [object valueForKeyPath:keyPath]);
    
}

- (void)updateViews
{
    NSURL *imageUrl = [NSURL URLWithString:self.pokemon.sprite];
    NSData *data = [NSData dataWithContentsOfURL:imageUrl];
    UIImage *image = [UIImage imageWithData:data];
    [self.imageView setImage:image];
    [self.nameLabel setText:self.pokemon.name];
    [self.identifierLabel setText:self.pokemon.identifier];
    NSString *abilities = [self.pokemon.abilities componentsJoinedByString:@", "];
    [self.abilitiesLabel setText:[NSString stringWithFormat:@"Abilities: %@", abilities]];
}


@end
