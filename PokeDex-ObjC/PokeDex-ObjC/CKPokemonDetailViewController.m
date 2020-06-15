//
//  CKPokemonDetailViewController.m
//  PokeDex-ObjC
//
//  Created by Christy Hicks on 6/14/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

#import "CKPokemonDetailViewController.h"

void *KVOContext = &KVOContext;

@interface CKPokemonDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *abilitiesLabel;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *attributesView;

@end

@implementation CKPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.pokemon.name.capitalizedString;
    
    self.mainView.layer.cornerRadius = 12;
    self.mainView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.mainView.layer.shadowOpacity = 2;
    self.mainView.layer.shadowOffset = CGSizeZero;
    self.mainView.layer.shadowRadius = 12;
    
    self.attributesView.layer.cornerRadius = 12;
    self.attributesView.layer.cornerRadius = 12;
    self.attributesView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.attributesView.layer.shadowOpacity = 2;
    self.attributesView.layer.shadowOffset = CGSizeZero;
    self.attributesView.layer.shadowRadius = 10;
    
    
    [self.pokemonController fetchDetailsFor:self.pokemon];
    [self.pokemon addObserver:self forKeyPath:@"identifier" options:0 context:KVOContext];
    [self.pokemon addObserver:self forKeyPath:@"abilities" options:0 context:KVOContext];
    [self.pokemon addObserver:self forKeyPath:@"image" options:0 context:KVOContext];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"identifier"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"abilities"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"image"]) {
            [self fetchImage];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.nameLabel.text = self.pokemon.name.capitalizedString;
        self.idLabel.text = [NSString stringWithFormat:@"%i", self.pokemon.identifier];

        NSString *joinedComponents = [self.pokemon.abilities componentsJoinedByString:@", "];
        self.abilitiesLabel.text = joinedComponents;

    });
}

- (void)fetchImage {
    [self.pokemonController fetchImageAt:self.pokemon.image completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageView setImage:image];
        });

    }];
}

- (void)dealloc {
    [self.pokemon removeObserver:self forKeyPath:@"identifier" context:KVOContext];
    [self.pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
    [self.pokemon removeObserver:self forKeyPath:@"image" context:KVOContext];
}

@end
