//
//  JDSPokemonDetailViewController.m
//  Pokedex_ObjC
//
//  Created by Lambda_School_Loaner_214 on 11/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

#import "JDSPokemonDetailViewController.h"
#import "Pokedex_ObjC-Swift.h"

@interface JDSPokemonDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTV;
@end

@implementation JDSPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[JDSPokemonController sharedController] fillInDetailsFor:self.pokemon];
    [self updateViews];
    if (!self.pokemon.idNumber) {
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

- (void)updateViews {
    if (self.pokemon) {
        self.title = [self.pokemon.name capitalizedString];
        self.nameLabel.text = [self.pokemon.name capitalizedString];
        if (self.pokemon.abilities) {
            [self loadImage];
            self.idLabel.text = [NSString stringWithFormat:@"%@", self.pokemon.idNumber];
            NSString *abilities = [[self.pokemon.abilities componentsJoinedByString:@", "] capitalizedString];
            self.abilitiesTV.text = abilities;
        }
    }
}

- (void)loadImage {
    if (self.pokemon.spriteURL) {
        //NSLog(@"Loading image for %@ from %@", self.pokemon.name, self.pokemon.spriteURL);
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:self.pokemon.spriteURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error:  could not get sprite: %@", error);
                return;
            }
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[self imageView] setImage:image];
                });
            }
        }];
        [dataTask resume];
    }
}

@end
