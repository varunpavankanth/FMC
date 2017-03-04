//
//  ContactUs.m
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "ContactUs.h"

@interface ContactUs ()<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>
#define FOR_MORE_APPS @"FOR_MORE_APPS"
#define FOLLOW_US @"FOLLOW_US"
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSourceArray;
@end

@implementation ContactUs

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Contact Us";
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    backgroundView.frame=self.view.frame;
    backgroundView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self prepareDataSource];
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 44.0;
    [self.view addSubview:_tableView];
    [self prepareTableHeaderView];
    [self prepareTableViewFooterView];
    
    
}

- (void)prepareTableHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 85)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    CGFloat width = 140;
    CGFloat padding = 10;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"versatile"]];
    imageView.frame = CGRectMake((view.frame.size.width - width)/2, padding, width, view.frame.size.height - 2*padding);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [view addSubview:imageView];
    
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    self.tableView.tableHeaderView = view;
}
- (void)prepareTableViewFooterView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 60)];
    [view setBackgroundColor:[UIColor clearColor]];
    CGFloat padding = 18;
    CGFloat topPadding = 10;
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    shareButton.frame = CGRectMake(padding , topPadding, self.tableView.frame.size.width - 2*padding, view.frame.size.height - 2*topPadding);
    [shareButton addTarget:self action:@selector(onShareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[shareButton setBackgroundColor:[Utility getDefaultSelectedBackGroundColor]];
    [shareButton setTitle:@"Share this App" forState:UIControlStateNormal];
    [shareButton.layer setCornerRadius:7.0];
    UIImage *btnImage = [UIImage imageNamed:@"share.png"];
    [shareButton setImage:btnImage forState:UIControlStateNormal];
    //shareButton.image=[UIImage imageNamed:@"11.png"];
    //[shareButton setBackgroundImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    shareButton.backgroundColor=[UIColor clearColor];
    [view addSubview:shareButton];
    
    self.tableView.tableFooterView = view;
    
}

- (void)onShareButtonClicked:(id)sender{
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:@"https://itunes.apple.com/us/app/kcr-the-leader/id1113302037?mt=8",nil] applicationActivities:nil];
    [self presentViewController:activity animated:YES completion:nil];
}
- (void)prepareDataSource{
    
    if (!_dataSourceArray){
        _dataSourceArray = [[NSMutableArray alloc] init];
    }
    else{
        [_dataSourceArray removeAllObjects];
    }
    
    //Contact
    NSMutableDictionary *contactDict = [NSMutableDictionary dictionary];
    [contactDict setObject:@"Contact" forKey:@"HeaderTitle"];
    
    NSMutableArray *contactRowsArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"+91 - 9701930011/22" forKey:@"value"];
    [phoneDict setObject:@"static" forKey:@"type"];
    [phoneDict setObject:@"phone" forKey:@"image"];
    [contactRowsArray addObject:phoneDict];
    
    NSMutableDictionary *landLineDict = [NSMutableDictionary dictionary];
    [landLineDict setObject:@"+91 - 4064557448/84" forKey:@"value"];
    [landLineDict setObject:@"static" forKey:@"type"];
    [landLineDict setObject:@"landline" forKey:@"image"];
    [contactRowsArray addObject:landLineDict];
    
    NSMutableDictionary *emailDict = [NSMutableDictionary dictionary];
    [emailDict setObject:@"versatilemobitech@gmail.com" forKey:@"value"];
    [emailDict setObject:@"static" forKey:@"type"];
    [emailDict setObject:@"mail" forKey:@"image"];
    
    [contactRowsArray addObject:emailDict];
    
    NSMutableDictionary *websiteDict = [NSMutableDictionary dictionary];
    [websiteDict setObject:@"www.versatilemobitech.com" forKey:@"value"];
    [websiteDict setObject:@"static" forKey:@"type"];
    [websiteDict setObject:@"website" forKey:@"image"];
    
    [contactRowsArray addObject:websiteDict];
    
    [contactDict setObject:contactRowsArray forKey:@"rows"];
    [_dataSourceArray addObject:contactDict];
    
    //For More Apps
    //    NSMutableDictionary *moreAppsDict = [NSMutableDictionary dictionary];
    //    [moreAppsDict setObject:@"For more apps" forKey:@"HeaderTitle"];
    //    [moreAppsDict setObject:FOR_MORE_APPS forKey:@"sectiontype"];
    //    NSMutableArray *moresAppsArray = [[NSMutableArray alloc] init];
    //
    //    NSMutableDictionary *dataDcit = [NSMutableDictionary dictionary];
    //    [moresAppsArray addObject:dataDcit];
    //    [moreAppsDict setObject:moresAppsArray forKey:@"rows"];
    //
    //    [_dataSourceArray addObject:moreAppsDict];
    
    //For Follow US
    NSMutableDictionary *followUsDict = [NSMutableDictionary dictionary];
    [followUsDict setObject:@"Follow us on" forKey:@"HeaderTitle"];
    [followUsDict setObject:FOLLOW_US forKey:@"sectiontype"];
    NSMutableArray *followUsArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *followDict = [NSMutableDictionary dictionary];
    [followUsArray addObject:followDict];
    
    [followUsDict setObject:followUsArray forKey:@"rows"];
    [_dataSourceArray addObject:followUsDict];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSourceArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableDictionary *sectionDict = [_dataSourceArray objectAtIndex:section];
    NSMutableArray *rowsArray = [sectionDict objectForKey:@"rows"];
    return rowsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    
    NSMutableDictionary *sectionDict = [_dataSourceArray objectAtIndex:indexPath.section];
    NSMutableArray *rowsArray = [sectionDict objectForKey:@"rows"];
    NSDictionary *dict = [rowsArray objectAtIndex:indexPath.row];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.backgroundColor=[UIColor clearColor];
    if ([[sectionDict objectForKey:@"sectiontype"] isEqualToString:FOR_MORE_APPS]){
        
        UIButton *playStoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        CGFloat yPadding = 5;
        CGFloat xPadding = 20;
        
        CGFloat buttonWidth = (cell.frame.size.width - 3*xPadding)/2;
        CGFloat buttonHeight = 50;
        
        //        [playStoreButton setFrame:CGRectMake(xPadding,yPadding, buttonWidth,buttonHeight)];
        //        [playStoreButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
        //        //        [playStoreButton setBackgroundImage:[UIImage imageNamed:@"blackbutton"] forState:UIControlStateNormal];
        //        [playStoreButton setBackgroundImage:[UIImage imageNamed:@"playstoreicon"] forState:UIControlStateNormal];
        //        [playStoreButton addTarget:self action:@selector(onPlayStoreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //        //        [playStoreButton setTintColor:[UIColor whiteColor]];
        //        //        [playStoreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        //        [playStoreButton.titleLabel setNumberOfLines:0];
        //        [playStoreButton.layer setCornerRadius:5.0];
        //
        //        [cell.contentView addSubview:playStoreButton];
        //
        //        UIButton *appStoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
        //        [appStoreButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
        //        [appStoreButton setBackgroundImage:[UIImage imageNamed:@"appstoreicon"] forState:UIControlStateNormal];
        //        [appStoreButton addTarget:self action:@selector(onAppStoreBtnClciked:) forControlEvents:UIControlEventTouchUpInside];
        //        [appStoreButton setFrame:CGRectMake(CGRectGetMaxX(playStoreButton.frame)+xPadding,yPadding, buttonWidth,buttonHeight)];
        //        //        [appStoreButton setTintColor:[UIColor whiteColor]];
        //        [appStoreButton.titleLabel setNumberOfLines:0];
        //        [appStoreButton .layer setCornerRadius:5.0];
        //        //        [appStoreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        //        [cell.contentView addSubview:appStoreButton];
        
    }
    else if ([[sectionDict objectForKey:@"sectiontype"] isEqualToString:FOLLOW_US]){
        
        CGRect frame = [tableView rectForRowAtIndexPath:indexPath];
        CGFloat xPadding = 20;
        CGFloat yPadding = 5;
        
        CGFloat width = frame.size.height - 2*yPadding;
        CGFloat height = width;
        
        CGFloat padding = (frame.size.width - 2*xPadding - 5*width)/4;
        
        for (int i = 0; i < 5 ; i++){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            if (i == 0){
                [button setBackgroundImage:[UIImage imageNamed:@"facebook"] forState:UIControlStateNormal];
            }
            else if (i == 1){
                [button setBackgroundImage:[UIImage imageNamed:@"googleplus"] forState:UIControlStateNormal];
            }
            
            else if (i == 2){
                [button setBackgroundImage:[UIImage imageNamed:@"twitter"] forState:UIControlStateNormal];
            }
            else if (i == 3){
                [button setBackgroundImage:[UIImage imageNamed:@"linkedin"] forState:UIControlStateNormal];
            }
            [button setFrame:CGRectMake(xPadding, yPadding, width, height)];
            [button.layer setCornerRadius:width/2];
            [button setTag:i];
            [button setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin];
            [button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
            xPadding += width+padding;
        }
    }
    else{
        cell.textLabel.text = [dict objectForKey:@"value"];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
        
        UIImage *image = [UIImage imageNamed:[dict objectForKey:@"image"]];
        if (image != nil){
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            cell.imageView.image = image;
            cell.imageView.tintColor = [UIColor blackColor];
        }
        else{
            cell.imageView.image = nil;
        }
        
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1){
        if (indexPath.row == 0){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Call Using" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction * number1Btn = [UIAlertAction actionWithTitle:@"+91 9701930011" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *phoneNumber = [@"tel://" stringByAppendingString:@"9701930011"];
             //   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:phoneNumber] options:@{} completionHandler:nil];
                
            }];
            [alert addAction:number1Btn];
            UIAlertAction * number2Btn = [UIAlertAction actionWithTitle:@"+91 9701930022" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *phoneNumber = [@"tel://" stringByAppendingString:@"9701930022"];
              //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:phoneNumber] options:@{} completionHandler:nil];
                
            }];
            [alert addAction:number2Btn];
            UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancelButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else if (indexPath.row == 1){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Call Using" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction * number1Btn = [UIAlertAction actionWithTitle:@"+91 4064557448" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *phoneNumber = [@"tel://" stringByAppendingString:@"04064557448"];
               // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:phoneNumber] options:@{} completionHandler:nil];
                
            }];
            [alert addAction:number1Btn];
            UIAlertAction * number2Btn = [UIAlertAction actionWithTitle:@"+91 4064557484" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *phoneNumber = [@"tel://" stringByAppendingString:@"04064557484"];
//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
                 [[UIApplication sharedApplication]openURL:[NSURL URLWithString:phoneNumber] options:@{} completionHandler:nil];
                
            }];
            [alert addAction:number2Btn];
            UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:cancelButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        else if (indexPath.row == 2){
            NSMutableDictionary *sectionDict = [_dataSourceArray objectAtIndex:indexPath.section];
            NSMutableArray *rowsArray = [sectionDict objectForKey:@"rows"];
            NSDictionary *dict = [rowsArray objectAtIndex:indexPath.row];
            NSString *valueString = [dict objectForKey:@"value"];
            
            MFMailComposeViewController *mailComposeVC = [[MFMailComposeViewController alloc] init];
            if ([MFMailComposeViewController canSendMail]){
                [mailComposeVC setToRecipients:[NSArray arrayWithObject:valueString]];
                [mailComposeVC setMailComposeDelegate:self];
                [self presentViewController:mailComposeVC animated:YES completion:nil];
            }
        }
        else if (indexPath.row == 3){
            NSString *urlString = @"http://www.versatilemobitech.com";
            
            if (urlString.length > 0){
               // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                 [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
            }
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSMutableDictionary *sectionDict = [_dataSourceArray objectAtIndex:section];
    NSString *headerTitle = [sectionDict objectForKey:@"HeaderTitle"];
    if (headerTitle.length > 0){
        return headerTitle;
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *sectionDict = [_dataSourceArray objectAtIndex:indexPath.section];
    NSMutableArray *rowsArray = [sectionDict objectForKey:@"rows"];
    NSDictionary *dict = [rowsArray objectAtIndex:indexPath.row];
    if ([[sectionDict objectForKey:@"sectiontype"] isEqualToString:FOR_MORE_APPS] ){
        return 60;
    }
    else if ([[sectionDict objectForKey:@"sectiontype"] isEqualToString:FOLLOW_US]){
        return 60;
    }
    else if ([[dict objectForKey:@"type"] isEqualToString:@"dynamic"]){
        return UITableViewAutomaticDimension;
    }
    return 30;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.02f;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]){
        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;
        tableViewHeaderFooterView.textLabel.textColor = [UIColor blackColor];
        tableViewHeaderFooterView.textLabel.backgroundColor = [UIColor clearColor];
        tableViewHeaderFooterView.textLabel.text = tableViewHeaderFooterView.textLabel.text.capitalizedString;
        tableViewHeaderFooterView.backgroundView.backgroundColor = [UIColor clearColor];
        tableViewHeaderFooterView.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    }
}

//- (void)onAppStoreBtnClciked:(id)sender{
//    NSString *urlString = @"https://itunes.apple.com/us/developer/versatile-mobitech/id1072655077";
//
//    if (urlString.length > 0){
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//    }
//}
//
//- (void)onPlayStoreBtnClicked:(id)sender{
//    NSString *urlString = @"https://play.google.com/store/search?q=versatilemobitech&hl=en";
//
//    if (urlString.length > 0){
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//    }
//}

- (void)onButtonClicked:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    NSString *urlString = @"";
    
    if (button.tag == 0){
        urlString = @"https://www.facebook.com/versatile.mobitech/";
    }
    else if (button.tag == 1){
        urlString = @"https://plus.google.com/u/0/105152463775757641701";
    }
    
    else if (button.tag == 2){
        urlString = @"https://twitter.com/VMobitech";
    }
    else if (button.tag == 3){
        urlString = @"https://www.linkedin.com/in/VersatileMobitech";
    }
    
    if (urlString.length > 0){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
      //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [controller dismissViewControllerAnimated:YES completion:nil];
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
