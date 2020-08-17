//
//  PokemonDetailViewController.m
//  PokedexObjC
//
//  Created by Sean Acres on 8/16/20.
//  Copyright © 2020 Sean Acres. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "PokedexObjC-Swift.h"

void *KVOContext = &KVOContext;

@interface PokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation PokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pokemon addObserver:self forKeyPath:@"urlString" options:0 context:KVOContext];
    [PokemonController.sharedController fillInDetailsFor:self.pokemon];
}

- (void)updateViews
{
    if (self.pokemon.urlString) {
        self.nameLabel.text = self.pokemon.name;
        self.idLabel.text = self.pokemon.identifier;
        self.abilitiesLabel.text = [self.pokemon.abilities componentsJoinedByString:@", "];
        [self setImageForURLString:self.pokemon.urlString];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"urlString"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateViews];
            });
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    [self.pokemon removeObserver:self forKeyPath:@"urlString" context:KVOContext];
}

- (void)setImageForURLString:(NSString *)urlString
{
    NSURL *imageURL = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error fetching image data: %@", error);
            return;
        }
        
        if (data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = [UIImage imageWithData:data];
            });
        }
    }] resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
