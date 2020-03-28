//
//  DetailViewController.m
//  Pokedex
//
//  Created by Michael on 3/27/20.
//  Copyright © 2020 Michael. All rights reserved.
//

#import "DetailViewController.h"
#import "MBMPokemon.h"



void *KVOContext = &KVOContext;

@interface DetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *abilitiesLabel;
@property (strong, nonatomic) IBOutlet UILabel *actualAbilitiesLabel;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.aPokemon addObserver:self forKeyPath:@"identifier" options:0 context:KVOContext];
    [self.aPokemon addObserver:self forKeyPath:@"ability" options:0 context:KVOContext];
    [self.aPokemon addObserver:self forKeyPath:@"frontImage" options:0 context:KVOContext];
    [self.pokemonAPI fillInDetailsFor:self.aPokemon];
    
//    [self updateViews];
}


- (void)updateViews {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.aPokemon.name];
        self.idLabel.text = [NSString stringWithFormat:@"ID: %@", self.aPokemon.identifier];
        NSString *stringAbilities = [self.aPokemon.ability componentsJoinedByString:@"\n"];
        
        
        self.actualAbilitiesLabel.text = stringAbilities;
        NSData *data = [[NSData alloc] initWithContentsOfURL:self.aPokemon.frontImage];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        self.imageView.image = image;
    });
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == KVOContext) {
        NSLog(@"%@: %@", keyPath, [object valueForKeyPath:keyPath]);
        if ([keyPath isEqualToString:@"identifier"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"ability"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"frontImage"]) {
            [self updateViews];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        
    }
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
