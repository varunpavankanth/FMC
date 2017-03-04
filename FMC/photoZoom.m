//
//  photoZoom.m
//  FMC
//
//  Created by Nennu on 27/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "photoZoom.h"
#import "UIImageView+WebCache.h"

@interface photoZoom ()
{
    UIImageView *ImageView;
    UILabel*lab;
    
}

@end

@implementation photoZoom

- (void)viewDidLoad {
    [super viewDidLoad];
    ImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 125,CGRectGetWidth(self.view.frame) , 250)];
    [ImageView sd_setImageWithURL:self.imageUrl placeholderImage:[UIImage imageNamed:@"deafult_icon.png"]];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:ImageView];
    
    if(self.dic)
    {
    lab=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(ImageView.frame)+10, CGRectGetWidth(self.view.frame), 0)];

    NSString *tittle=[self.dic objectForKey:@"image_title"];
    NSString *discrption=[self.dic objectForKey:@"image_description"];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM dd,yyyy hh:mm a"];
    NSString *date=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    NSString *text = [NSString stringWithFormat:@"%@ \n %@\n%@",tittle ,discrption,date];
    NSMutableAttributedString *attributedtext=[[NSMutableAttributedString alloc]initWithString:text];
    NSRange  range1=[text rangeOfString:tittle];
    NSRange  range2=[text rangeOfString:discrption];
    NSRange  range3=[text rangeOfString:date];
    [attributedtext setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0],
                                    NSFontAttributeName:[UIFont fontWithName:@"Roboto-Regular" size:20]} range:range1];
    [attributedtext setAttributes:@{NSForegroundColorAttributeName: [UIColor orangeColor],
                                    NSFontAttributeName:[UIFont fontWithName:@"Roboto-Light" size:20]} range:range2];
    [attributedtext setAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                    NSFontAttributeName:[UIFont fontWithName:@"Roboto-Light" size:20]} range:range3];
    lab.attributedText=attributedtext;
    lab.numberOfLines=0;
    [lab sizeToFit];

    [self.view  addSubview:lab];
    
}

    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
