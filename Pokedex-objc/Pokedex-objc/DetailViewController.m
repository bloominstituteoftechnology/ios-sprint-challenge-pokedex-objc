//
//  DetailViewController.m
//  Pokedex-objc
//
//  Created by Matthew Martindale on 8/16/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import "DetailViewController.h"
void *KVOContext = &KVOContext;

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MKMPokemonAPI.sharedController fillInDetails:self.pokemon];
    [self.pokemon addObserver:self forKeyPath:@"identifier" options:0 context:KVOContext];
    [self.pokemon addObserver:self forKeyPath:@"abilities" options:0 context:KVOContext];
    [self.pokemon addObserver:self forKeyPath:@"sprites" options:0 context:KVOContext];
}

- (void)updateViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.nameLabel.text = self.pokemon.name;
        self.idLabel.text = [NSString stringWithFormat:@"%d", self.pokemon.identifier];
        self.abilitiesTextView.text = self.pokemon.abilities;
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"sprites"]) {
            [self loadImage];
            [self updateViews];
        } else if ([keyPath isEqualToString:@"abilities"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"identifier"]) {
            [self updateViews];
        }
    }
}

- (void)loadImage {
    [MKMPokemonAPI.sharedController fetchImageWithUrl:self.pokemon.sprites completion:^(UIImage *image, NSError *error) {
        if (error) {
            NSLog(@"Error loading pokemon image");
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageView setImage:image];
        });
    }];
}

- (void)dealloc
{
    [self.pokemon removeObserver:self forKeyPath:@"identifier" context:KVOContext];
    [self.pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
    [self.pokemon removeObserver:self forKeyPath:@"sprites" context:KVOContext];
}

@end
