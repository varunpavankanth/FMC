//
//  Events.m
//  FMC
//
//  Created by Nennu on 10/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "Events.h"
#import "SVProgressHUD.h"
@interface Events ()<NSURLSessionDelegate,UIScrollViewDelegate>
{
    UIImage *down ;
    BOOL selected;
    NSInteger selectedButtonTag;
    NSMutableArray  * responseArray;
   BOOL acceptselected;
    UIView *PieProgressBarView;
    NSString *user_id;
    NSString *event_d;
    NSString *response_text;
    int pageNumber;
    int lastpage;
    NSUInteger myCount;
    NSDictionary *postdic;
    BOOL acceptordeclined;
}
@end

@implementation Events
@synthesize tv;
-(id)init
{
     user_id = [[NSUserDefaults standardUserDefaults]stringForKey:@"user_id"];
    pageNumber = 1;
    [self eventServercall];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
   
    response_text = [[NSString alloc]init];
    //    [[NSUserDefaults standardUserDefaults]stringForKey:@"user_id"];
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration ephemeralSessionConfiguration];
    self.urlSession= [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    selected=NO;
    
    //self.view.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    self.navigationItem.title=@"Events";
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        self.label1a=[[NSMutableArray alloc]initWithObjects:@"Vinod", nil];
    self.label2=[[NSMutableArray alloc]initWithObjects:@"Versatile", nil];
    
      self.label1=[[NSMutableArray alloc]initWithObjects:@"Rituyatra",@"Press meet",@"Janagarjana",@"RachaBanda",@"SwachBharath",@"Group", nil];
    // Do any additional setup after loading the view.
   tv=[[UITableView alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.view.frame)-15, CGRectGetHeight(self.view.frame))];
    tv.backgroundColor=[UIColor whiteColor];
    tv.delegate=self;
    tv.dataSource=self;
    tv.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
   // [tv sizeToFit];
    tv.estimatedRowHeight=1000;
    tv.rowHeight=UITableViewAutomaticDimension;
    self.tv.separatorColor = [UIColor clearColor];
    [tv setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:tv];
    
   }
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([postdic valueForKey:@"event_details"])
    {
        NSUInteger j=[[postdic valueForKey:@"total_number_of_posts"] integerValue];
        if (j!=0)
        {
            if (indexPath.section ==  responseArray.count-1) {
                NSLog(@"load more");
                pageNumber++;
                NSLog(@"page no:%d",pageNumber);
                [self eventServercall];
            }
        }
        else if(indexPath.section==myCount)
        {
            [self.view makeToast:@"No more data" duration:1.0 position:@"center"];
            
        }
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [tv reloadData];
}

//http://facilitymanagementcouncil.com/admin/service/events/{page number}/user_id


-(void)eventServercall

{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
    }
            else {
                
                NSString *URL =[NSString stringWithFormat:@"http://facilitymanagementcouncil.com/admin/service/events/%d/%@",pageNumber,user_id];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
                
                NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
                NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
                
                
                [request setHTTPMethod:@"GET"];
                              dispatch_async(dispatch_get_main_queue(), ^{

                NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (!error) {
                    
                    NSDictionary *dataJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    NSLog(@"%@", dataJSON);
                       
                        postdic = dataJSON;
                         NSUInteger j=[[dataJSON valueForKey:@"total_number_of_posts"] integerValue];
                        if (j==0) {
                            NSLog(@"nolonger data present ");
                            NSLog(@"last page no:%d",pageNumber);
                            lastpage=pageNumber;
                            pageNumber=1;
                            myCount = [responseArray count];
                        }
                        else
                        {
                         
                            if(!responseArray)
                            {
                                responseArray=[[dataJSON objectForKey:@"event_details"] mutableCopy];
                            }
                            else{
                               
                                if (j!=0) {
                                    
                                    NSMutableArray *arry=[[NSMutableArray alloc]init];
                                    arry=[[dataJSON objectForKey:@"posts_details"] mutableCopy];
                                    [(NSMutableArray *)responseArray addObjectsFromArray:arry]  ;
                                }
                            }
                            
                            [tv reloadData];
                            [SVProgressHUD dismiss];
                            
                        }
                        
                        
                    }
                }];

                [dataTask resume];
                  });


        }
    }
-(void)arrowaction:(UIButton*)sender
{
    selectedButtonTag = sender.tag;
    dic = [responseArray objectAtIndex:sender.tag];
   //  response = 1;
   
    
    selected=!selected;
    [self.tv reloadData];
    
    
}
//postdic=[postdetailsarray objectAtIndex:Sectionpath];
//NSInteger i=[[postdic valueForKey:@"likes_count"] integerValue];
//NSMutableDictionary *update=[[NSMutableDictionary alloc]initWithDictionary:postdic];
//[update setValue:@"1" forKey:@"already_liked"];
//i++;
//NSString *likes_count=[NSString stringWithFormat:@"%ld",i];
//[update setValue:likes_count forKey:@"likes_count"];
//[postdetailsarray replaceObjectAtIndex:Sectionpath withObject:update];
////        [tableview beginUpdates];
//dispatch_async(dispatch_get_main_queue(), ^{
//    [tableview reloadSections:[[NSIndexSet alloc] initWithIndex:Sectionpath+1] withRowAnimation:UITableViewRowAnimationNone];
//    
//});

-(void)acceptAction:(UIButton*)sender{
     acceptselected = sender.tag;
    dic = [responseArray objectAtIndex:sender.tag];
    event_d = [dic objectForKey:@"event_id"];
     int i=[[dic valueForKey:@"response"] intValue];
    if(i==0)
    {
        UIAlertController *alertController;
        alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Are you sure you want to attend the event"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
            response_text = @"Accept";
            [self postservercall];
            NSMutableDictionary *update=[[NSMutableDictionary alloc]initWithDictionary:dic];
            [update setValue:@"1" forKey:@"response"];
            [responseArray replaceObjectAtIndex:sender.tag withObject:update];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
             [alertController dismissViewControllerAnimated:YES completion:nil];
           
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    
    }
    else{
        
         [self.view makeToast:@"You Have already responded this event" duration:1.0 position:@"bottom"];
    }
    
}
-(void)declinAction:(UIButton*)sender{
     acceptselected = sender.tag;
    dic = [responseArray objectAtIndex:sender.tag];
     event_d = [dic objectForKey:@"event_id"];
      int i=[[dic valueForKey:@"response"] intValue];
    if(i==0)
    {
        UIAlertController *alertController;
        alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Are you sure you want to attend the event"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];

     response_text = @"Decline";
    [self postservercall];
    NSMutableDictionary *update=[[NSMutableDictionary alloc]initWithDictionary:dic];
    [update setValue:@"1" forKey:@"response"];
    [responseArray replaceObjectAtIndex:sender.tag withObject:update];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
         [self.view makeToast:@"You Have already responded this event" duration:1.0 position:@"bottom"];
    }

}
//http://facilitymanagementcouncil.com/admin/service/eventresponse
-(void)postservercall{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    UIAlertController *alertController;
    if (networkStatus == NotReachable)
    {
        [self.view makeToast:@"No internet connection" duration:1.0 position:@"center"];
    }
    else
    {
       
        if ([user_id isEqualToString:@""]) {
            alertController = [UIAlertController  alertControllerWithTitle:@"Error"  message:@"Please enter the User name"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else {
            
            NSString * mystring =[NSString stringWithFormat:@"event_id=%@&user_id=%@&response_text=%@",event_d,user_id,response_text];
            NSLog(@"mystring%@",mystring);
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:@"http://facilitymanagementcouncil.com/admin/service/eventresponse"]];
            [request setHTTPMethod:@"POST"];
            // [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:[mystring dataUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"%@",request);
            NSURLSessionDataTask *dataTask =[self.urlSession dataTaskWithRequest:request];
            dict=nil;
            [dataTask resume];
        }
    }
    
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data1
{
    
    id json = [NSJSONSerialization JSONObjectWithData:data1 options:0 error:nil];
    
    if(dict == nil)
    {
        dict=json;
    }
    else
    {
        dict = [dict initWithDictionary:json];
    
    }
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    
    error1=error;
    dispatch_async(dispatch_get_main_queue(), ^{[self sucesstask];});
    
}
-(void)sucesstask
{
   // NSLog(@"responseData%@",dict);
  //  [tv reloadData];
    UIAlertController *alertController;
    if(dict!=nil)
    {
        alertController = [UIAlertController  alertControllerWithTitle:@""  message:[dict valueForKey:@"message"]  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //  [self.navigationController popViewControllerAnimated:YES];
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        alertController = [UIAlertController  alertControllerWithTitle:@""  message:@"Opps something went  wrong"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //  [self.navigationController popViewControllerAnimated:YES];
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
  }

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return responseArray.count;}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if((selected) && (selectedButtonTag == indexPath.section))
    {

        return cell1.contentView.frame.size.height;
    }
    else
        return 120;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.backgroundColor = [UIColor clearColor];
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     cell1=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell1==nil) {
        cell1=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    [cell1.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        //[cell.layer setBorderWidth:2.0];
    [cell1.layer setCornerRadius:10.0f];
    cell1.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell1.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    cell1.layer.cornerRadius=7.0f;
    cell1.layer.borderWidth=1.0f;
    dic = [[NSMutableDictionary alloc]init];
    dic = [responseArray objectAtIndex:indexPath.section];
    UILabel *titlelable=[[UILabel alloc]initWithFrame:CGRectMake(10,5, CGRectGetMaxX(cell1.frame),25)];
    titlelable.text=[self stringWithSentenceCapitalization:[dic objectForKey:@"event_title"]];
    titlelable.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [cell1.contentView addSubview:titlelable];
    
    UILabel *Citylable=[[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(titlelable.frame)+5, CGRectGetMaxX(cell1.frame)-170,25)];
    Citylable.text=@"Hyderabad";
    Citylable.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [cell1.contentView addSubview:Citylable];
    
    
    UILabel *moredetailslable=[[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(Citylable.frame)+5,100,25)];
    if (!selected)
    moredetailslable.text=@"MoreDetails";
    else
       moredetailslable.text=@"LessDetails";
    moredetailslable.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    [cell1.contentView addSubview:moredetailslable];
    
    
    UIButton*Accept_btn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tableView.frame)-100, 45, 80, 25)];
    [Accept_btn setTitle:@"Accept" forState:UIControlStateNormal];
    Accept_btn.backgroundColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
     Accept_btn.tag =indexPath.section;
      [Accept_btn addTarget:self action:@selector(acceptAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell1.contentView addSubview:Accept_btn];
    
    UIButton*Declin_btn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tableView.frame)-100, 85, 80, 25)];
    [Declin_btn setTitle:@"Decline" forState:UIControlStateNormal];
    Declin_btn.backgroundColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    Declin_btn.tag =indexPath.section;
    [Declin_btn addTarget:self action:@selector(declinAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell1.contentView addSubview:Declin_btn];
    UIButton*arrow=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(moredetailslable.frame)+10, CGRectGetMinY(moredetailslable. frame), 40, 30)];
    arrow.tag =indexPath.section;
    [arrow addTarget:self action:@selector(arrowaction:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *aboutbtn = [UIImage imageNamed:@"downarrow.png"];
    [arrow setImage:aboutbtn forState:UIControlStateNormal];
    [arrow setBackgroundColor:[UIColor clearColor]];
   
    PieProgressBarView=[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(arrow. frame)+10,40,70,70)];
    PieProgressBarView.backgroundColor =[UIColor whiteColor];
     [cell1.contentView addSubview:PieProgressBarView];
   
        [self animateProgressBarToPercent:1.0];
       
    
    if((selected) && (selectedButtonTag == indexPath.section))
    {
       UILabel*Venu_lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 120, 30)];
        Venu_lbl.text=@"Venu";
        Venu_lbl.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        [cell1.contentView addSubview:Venu_lbl];
        UILabel*Venudetails=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Venu_lbl.frame)+10, 130, cell1.frame.size.width-Venu_lbl.frame.size.width-35, 30)];
        Venudetails.text=[NSString stringWithFormat:@": %@", [dic objectForKey:@"venue"]];
        [cell1.contentView addSubview:Venudetails];
         Venudetails.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    
        UILabel*Organaized_lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(Venu_lbl.frame)+10, 120, 30)];
        Organaized_lbl.text=@"Organaized By";
        Organaized_lbl.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        [cell1.contentView addSubview:Organaized_lbl];
        
        
        UILabel*Organaizeddetails=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Organaized_lbl.frame)+10, CGRectGetMaxY(Venu_lbl.frame)+20, cell1.frame.size.width-Organaized_lbl.frame.size.width-35, 30)];
         Organaizeddetails.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        Organaizeddetails.text= [NSString stringWithFormat:@": %@", [dic objectForKey:@"organized_by"]];
        [cell1.contentView addSubview:Organaizeddetails];
        UILabel*contactLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(Organaized_lbl.frame)+20, 120, 30)];
        contactLabel.text=@"Contact";
        contactLabel.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        [cell1.contentView addSubview:contactLabel];
        UILabel*ContactDetail=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(contactLabel.frame)+10, CGRectGetMaxY(Organaized_lbl.frame)+20, cell1.frame.size.width-contactLabel.frame.size.width-30, 30)];
        ContactDetail.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        ContactDetail.text=[NSString stringWithFormat:@": %@", [dic objectForKey:@"contact"]];
        [cell1.contentView addSubview:ContactDetail];
        UILabel*chiefGuestLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(contactLabel.frame)+20, 120, 30)];
        chiefGuestLabel.text=@"Chief Guest";
        chiefGuestLabel.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        [cell1.contentView addSubview:chiefGuestLabel];
        UILabel*CheifGuestDetails=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(chiefGuestLabel.frame)+10, CGRectGetMaxY(contactLabel.frame)+20, cell1.frame.size.width-chiefGuestLabel.frame.size.width-35, 30)];
        CheifGuestDetails.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        CheifGuestDetails.text=[NSString stringWithFormat:@": %@", [dic objectForKey:@"chief_guest"]];
        [cell1.contentView addSubview:CheifGuestDetails];
        UILabel*DateofEventLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(chiefGuestLabel.frame)+20, 120, 30)];
        DateofEventLabel.text=@"Date of Event";
        DateofEventLabel.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        [cell1.contentView addSubview:DateofEventLabel];
        UILabel*DateofEventDetails=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(DateofEventLabel.frame)+10, CGRectGetMaxY(chiefGuestLabel.frame)+20, cell1.frame.size.width-DateofEventLabel.frame.size.width-35, 30)];
        DateofEventDetails.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        DateofEventDetails.text=[NSString stringWithFormat:@": %@", [dic objectForKey:@"date_of_event"]];
       
        [cell1.contentView addSubview:DateofEventDetails];

        UILabel*Details_lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(DateofEventLabel.frame)+20, 120, 30)];
        Details_lbl.text=@"Details";
        Details_lbl.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        [cell1.contentView addSubview:Details_lbl];
        
        UILabel*detailsLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(Details_lbl.frame)+10, CGRectGetMaxY(DateofEventLabel.frame)+20, (cell1.frame.size.width-Details_lbl.frame.size.width)-35, 0)];
        detailsLabel.text= [NSString stringWithFormat:@": %@", [dic objectForKey:@"Details"]];
        detailsLabel.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
        detailsLabel.numberOfLines=0;
        [detailsLabel sizeToFit];
        [cell1.contentView addSubview:detailsLabel];
        
        CGRect frame=cell1.contentView.frame;
        frame.size.height=CGRectGetMaxY(detailsLabel.frame)+10;
         [arrow setImage:[UIImage imageNamed:@"uparrow"] forState:UIControlStateNormal];
        [cell1.contentView setFrame:frame];

    }
     [cell1.contentView addSubview:arrow];
    return cell1;
}

- (void)animateProgressBarToPercent:(float)percent
{
    if (percent > 1.0f) return;
    
    int radius = 30.0f;
    int strokeWidth = 7.f;
    CGColorRef color = [UIColor blueColor].CGColor;
    int timeInSeconds = percent * 1;
    
    CGFloat startAngle = 0;
    CGFloat middleAboveAngle = 0.6;
    CGFloat endAngle = percent;
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius) cornerRadius:radius].CGPath;
    circle.position = CGPointMake(strokeWidth, strokeWidth);
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = color;
    circle.lineWidth = strokeWidth;
    circle.strokeEnd = middleAboveAngle;
    
    CAShapeLayer *orangecircle = [[CAShapeLayer alloc] init];
    orangecircle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius) cornerRadius:radius].CGPath;
    orangecircle.position = CGPointMake(strokeWidth, strokeWidth);
    orangecircle.fillColor = [UIColor clearColor].CGColor;
    orangecircle.strokeColor =  [UIColor orangeColor].CGColor;
    orangecircle.lineWidth = strokeWidth;
    orangecircle.strokeStart=middleAboveAngle;
    orangecircle.strokeEnd = endAngle;
    [PieProgressBarView.layer addSublayer:orangecircle];
     [PieProgressBarView.layer addSublayer:circle];
    
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = timeInSeconds;
    drawAnimation.repeatCount         = 1.0;
    drawAnimation.removedOnCompletion = NO;
    
    drawAnimation.fromValue = [NSNumber numberWithFloat:startAngle];
    
    
    drawAnimation.toValue   = [NSNumber numberWithFloat:endAngle];
    
    
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    [orangecircle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    UILabel*eventDaysLabel=[[UILabel alloc]initWithFrame:CGRectMake(strokeWidth+5, 10, PieProgressBarView.frame.size.width -2*strokeWidth-10, 50)];
    
    NSString * DateString = [dic objectForKey:@"date_of_event"];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd,MMM,yyyy"];
    NSString *str3=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    eventDaysLabel.numberOfLines = 2;
    eventDaysLabel.textAlignment = NSTextAlignmentCenter;
    eventDaysLabel.font = [UIFont fontWithName:@"Roboto-Light" size:10];
    eventDaysLabel.textColor=[UIColor colorWithRed:0.12 green:0.16 blue:0.41 alpha:1.0];
    NSDate *startDate = [dateFormatter dateFromString:DateString];
    NSDate *endDate = [dateFormatter dateFromString:str3];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:endDate  toDate:startDate options:0];
    eventDaysLabel.text=[NSString stringWithFormat:@"%ld%@", (long)[components day],@" Days TO Go"];
    
    [PieProgressBarView addSubview:eventDaysLabel];
    
    
}

-(NSString*)stringWithSentenceCapitalization:(NSString*)str
{
    
    // Get the first character in the string and capitalize it.
    NSString *firstCapChar = [[str substringToIndex:1] capitalizedString];
    
    NSMutableString * temp = [str mutableCopy];
    
    // Replace the first character with the capitalized version.
    [temp replaceCharactersInRange:NSMakeRange(0, 1) withString:firstCapChar];
    
    return temp ;
}



@end
