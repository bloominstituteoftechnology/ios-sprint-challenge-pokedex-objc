//
//  JDBDetailViewController.m
//  Pokedex
//
//  Created by Madison Waters on 3/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

#import "JDBDetailViewController.h"
#import "JDBPokemon.h"
#import "Pokedex-Swift.h"

@interface JDBDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation JDBDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.pokemon.idNumber == nil) {
        [self.pokemon addObserver:self
                       forKeyPath:@"abilities"
                          options:0
                          context:nil];
    }
    
    [PokemonAPI.sharedController fillInDetailsFor:self.pokemon];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateViews];
}

- (void)updateViews {
    
    if (self.pokemon) {
        
        NSURL *imageURL = [NSURL URLWithString:self.pokemon.sprite];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^{ self.imageView.image = [UIImage imageWithData:imageData]; });
        
        self.nameLabel.text = [self.pokemon.name capitalizedString];
        self.abilitiesLabel.text = [self.pokemon.abilities componentsJoinedByString:@" \n"];
        
        NSString *idString = [NSString stringWithFormat:@"%ld", (long)self.pokemon.idNumber];
        self.idLabel.text = idString;
    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context {
    dispatch_async(dispatch_get_main_queue(), ^{ [self updateViews]; });
    [object removeObserver: self forKeyPath:keyPath];
}

@end
