//
//  DetailVC.m
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

#import "DetailVC.h"

@interface DetailVC ()

@property (nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic) IBOutlet UILabel *identifierLabel;
@property (nonatomic) IBOutlet UITextView *abilitiesTextView;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateViews];
}

- (void)updateViews {
    
}

@end
