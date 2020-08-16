//
//  PokemonDetailViewController.m
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "Pokemon_Objc-Swift.h"
#import "LSIPokemon.h"

@interface PokemonDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *abilitiesListLabel;
@property (strong, nonatomic) IBOutlet UILabel *idNumberLabel;

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self clearViews];
    
    if (self.pokemon) {
        self.nameLabel.text = [self.pokemon.name capitalizedString];
    }
}

- (void)clearViews
{
    self.imageView.image = nil;
    self.nameLabel.text = nil;
    self.abilitiesListLabel.text = nil;
    self.idNumberLabel.text = nil;
}

@end
