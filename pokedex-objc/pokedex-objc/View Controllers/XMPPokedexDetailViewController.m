//
//  XMPPokedexDetailViewController.m
//  pokedex-objc
//
//  Created by conner on 8/14/20.
//  Copyright © 2020 conner. All rights reserved.
//

#import "XMPPokedexDetailViewController.h"

@interface XMPPokedexDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstAbilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondAbilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdAbilityLabel;

@end

@implementation XMPPokedexDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
