//
//  DetailVC.m
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

#import "DetailVC.h"
#import "Pokemon.h"
#import "Pokedex-Swift.h"

@interface DetailVC ()

@property (nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic) IBOutlet UILabel *identifierLabel;
@property (nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updateViews
{
    _nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.pokemon.name];
    if (self.pokemon.identifier) {
        _identifierLabel.text = [NSString stringWithFormat:@"Identifier: %@", self.pokemon.identifier];
    }
    if (self.pokemon.abilities) {
        NSArray<NSString *> *abilityArray = [self.pokemon.abilities componentsSeparatedByString:@", "];
        NSString *abilityString = @"";
        for (NSString *ability in abilityArray) {
            abilityString = [NSString stringWithFormat:@"%@\n%@", abilityString, ability];
        }
        _abilitiesTextView.text = abilityString;
    }
    if (![self.pokemon.spriteURL isEqual:@""]) {
        NSURL *url = [NSURL URLWithString:self.pokemon.spriteURL];
        [PokemonAPI.sharedController fetchImageWithUrl:url completion:^(UIImage *image, NSError *error) {
            if (error) {
                NSLog(@"Error fetching image: \(error)");
            }
            if (image) {
                self.imageView.image = image;
            }
        }];
    }
}

@end
