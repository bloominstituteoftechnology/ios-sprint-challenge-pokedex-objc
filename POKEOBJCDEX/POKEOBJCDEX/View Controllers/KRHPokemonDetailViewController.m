//
//  KRHPokemonDetailViewController.m
//  POKEOBJCDEX
//
//  Created by Kelson Hartle on 8/16/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

#import "KRHPokemonDetailViewController.h"
#import "KRHPokemon.h"
#import "POKEOBJCDEX-Swift.h"

void *KVOContext = &KVOContext;

@interface KRHPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation KRHPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonAPI.sharedController fillInDetailsFor:self.pokemon];
    [self.pokemon addObserver:self forKeyPath:@"identifier" options:0 context:KVOContext];
    [self.pokemon addObserver:self forKeyPath:@"abilitiesArray" options:0 context:KVOContext];
    [self.pokemon addObserver:self forKeyPath:@"image" options:0 context:KVOContext];
}

-(void)updateViews {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.title = self.pokemon.name;

        self.nameLabel.text = self.pokemon.name;
        self.idLabel.text = [[NSString alloc] initWithFormat:@"%@", self.pokemon.identifier];

        NSString *stringOfAbilities = [self.pokemon.abilitiesArray componentsJoinedByString:@"\n"];

        self.abilitiesLabel.text = [[NSString alloc]initWithFormat: @"%@", stringOfAbilities];
    });
}

- (void)downloadImageWithURL:(NSURL *)url {
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", url);
       
        if (error) {
            NSLog(@"Error downloading image: %@", error);
        }
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    }];
    
    [task resume];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
        if (context == KVOContext) {
               if ([keyPath isEqualToString:@"identifier"]) {
                   [self updateViews];
               } else if ([keyPath isEqualToString:@"abilitiesArray"]) {
                   [self updateViews];
               } else if ([keyPath isEqualToString:@"image"]) {
                   [self downloadImageWithURL:self.pokemon.image];
               }
           } else {
               [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
           }
}

- (void)dealloc
{
    [self.pokemon removeObserver:self forKeyPath:@"identifier" context:KVOContext];
    [self.pokemon removeObserver:self forKeyPath:@"abilitiesArray" context:KVOContext];
    [self.pokemon removeObserver:self forKeyPath:@"image" context:KVOContext];
}


@end
