//
//  MTGDetailViewController.m
//  Pokedex
//
//  Created by Mark Gerrior on 5/22/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

#import "MTGDetailViewController.h"
#import "Pokedex-Swift.h"

@interface MTGDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UITextView *abilityTextField;

@end

@implementation MTGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self updateViews];

    if (self.pokemon.identifier == nil ||
        self.pokemon.image == nil ||
        self.pokemon.abilities == nil)
    {
        [PokemonAPI.sharedController fillInDetailsFor:self.pokemon];
    }

}

- (void) updateViews {
    self.nameLabel.text = self.pokemon.name;
    self.imageView.image = self.pokemon.image;
    self.idLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.identifier];

    NSString *abilityText = @"";

    for (int i = 0; i < self.pokemon.abilities.count; i++)
    {
//        NSLog(@"%@", [self.pokemon.abilities objectAtIndex:i]);

        [NSString stringWithFormat:@"%@%@\n", abilityText, [self.pokemon.abilities objectAtIndex:i]];
    }

    self.abilityTextField.text = abilityText;
}
@end
