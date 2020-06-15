//
//  WASDetailViewController.m
//  Pokedex-Objective-C
//
//  Created by Alex Shillingford on 6/14/20.
//  Copyright © 2020 shillwil. All rights reserved.
//

#import "WASDetailViewController.h"
#import "Pokedex_Objective_C-Swift.h"

@interface WASDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation WASDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[WASPokemonController sharedController] fillInDetailsFor:self.pokemon];
    [self updateViews];
    if (!self.pokemon.identifier) {
        [self.pokemon addObserver:self forKeyPath:@"abilities" options:0 context:nil];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self updateViews];
    });
    [object removeObserver:self forKeyPath:keyPath];
}

- (void)updateViews
{
    if (self.pokemon) {
        self.title = [self.pokemon.name capitalizedString];
        self.nameLabel.text = [self.pokemon.name capitalizedString];
        if (self.pokemon.abilities) {
            [self loadImage];
            self.idLabel.text = [NSString stringWithFormat:@"%d", self.pokemon.identifier];
            NSString *abilities = self.pokemon.abilities;
            self.abilitiesLabel.text = abilities;
        }
    }
}

- (void)loadImage
{
    if (self.pokemon.frontImage) {
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:self.pokemon.frontImage completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error:  could not get sprite: %@", error);
                return;
            }
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[self pokeImageView] setImage:image];
                });
            }
        }];
        [dataTask resume];
    }
}

@end
