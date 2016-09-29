//
//  AboutMeViewController.m
//  车行天下
//
//  Created by 剑试蔷薇 on 15/11/10.
//  Copyright (c) 2015年 余晓光. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,assign)NSInteger rubbishcount;
@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self createTableView];
}
-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *identifier=@"cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell==nil){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image=[UIImage imageNamed:@"iconfont-qingli"];
        cell.textLabel.text=@"清空缓存";
        return cell;
    }else{
        static NSString *identifier=@"cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell==nil){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image=[UIImage imageNamed:@"iconfont-about"];
        cell.textLabel.text=@"关于";
        return cell;
    }
    
}
#pragma mark --UIAlertViewDelete
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self removeCache];
        
    }
    
    
}
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    return 9 ;
}
-(CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4;
}

-(void)showCache{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    _rubbishcount=[files count];
}


-(void)removeCache
{
    //===============清除缓存==============
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for (NSString *p in files)
    {
        NSError *error;
        NSString *path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self showCache];
    if (indexPath.section==0) {
        UIAlertView *av=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"缓存文件:%@个,确定清空缓存?",[[NSNumber numberWithInteger:_rubbishcount] stringValue]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清除", nil];
        [av show];

    }else if (indexPath.section==1){
        UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"关于" message:@"当前版本  V1.0" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [av show];
    }
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
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
