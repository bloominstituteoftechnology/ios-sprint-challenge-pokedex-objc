//
//  JMKPokeDexDetailViewController.m
//  PokeDexObjC
//
//  Created by TuneUp Shop  on 3/15/19.
//  Copyright © 2019 jkaunert. All rights reserved.
//

#import "JMKPokeDexDetailViewController.h"


@interface JMKPokeDexDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonSpriteImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesListLabel;

@end

@implementation JMKPokeDexDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
    [_pokemon addObserver:self forKeyPath:@"abilities" options:0 context:NULL];
}

- (void)updateViews
{
    if (self.pokemon) {
        self.pokemonNameLabel.text = [NSString stringWithFormat:@"Name: %@", self.pokemon.name];
        self.pokemonIDLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.identifier];
        self.abilitiesListLabel.text = [NSString stringWithFormat:@"%@\n", self.pokemon.abilitiesString];
        
        if (self.pokemon.spriteURL) {
            NSData *imageData = [NSData dataWithContentsOfURL:self.pokemon.spriteURL];
            UIImage *tempImage = [UIImage imageWithData:imageData];
            self.pokemonSpriteImageView.image = tempImage;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self updateViews];
    });
    [object removeObserver:self forKeyPath:keyPath];
}
@end
