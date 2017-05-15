//
//  TableViewController.m
//  YiRefresh
//
//  Created by coderyi on 15/3/5.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import "TableViewController.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "TableViewModel.h"
#import "TableViewProtocol.h"
#import "LoginViewController.h"


@interface TableViewController ()
@property (nonatomic, strong) YiRefreshHeader *refreshHeader;
@property (nonatomic, strong) YiRefreshFooter *refreshFooter;
@property (nonatomic, strong) TableViewModel *tableViewModel;
@property (nonatomic, strong) TableViewProtocol *tableViewProtocol;
@property (nonatomic, strong) NSMutableArray *totalSource;//所有门店数据数组
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *loading; //加载中视图

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    self.title=@"MVVMDemo With TableView";
    self.view.backgroundColor=[UIColor whiteColor];
    
    /*  初始化TableViewModel */
    _tableViewModel=[[TableViewModel alloc] init];
    
    /*  初始化TableViewProtocol */
    _tableViewProtocol = [[TableViewProtocol alloc]initWithTableViewModel:_tableViewModel];
    __weak typeof(self) weakSelf = self;
    [_tableViewProtocol returnSelectedCell:^(NSIndexPath *indexPath) { //选中行的回调
        LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.navigationController pushViewController:loginVC animated:YES];
        
    }];
    
    /*  初始化TableView */
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource=_tableViewProtocol;
    _tableView.delegate=_tableViewProtocol;
    _tableView.rowHeight = 103; //设置行高
    
    /*  初始化加载中视图 */
    _loading = [[UILabel alloc]initWithFrame:self.view.bounds];
    _loading.text = @"加载中……";
    _loading.font = [UIFont systemFontOfSize:18];
    _loading.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_loading];
    
    _totalSource=[NSMutableArray array];
    
    /* YiRefreshHeader  头部刷新按钮的使用 */
    _refreshHeader=[[YiRefreshHeader alloc] init];
    _refreshHeader.scrollView=_tableView;
    [self.refreshHeader header];
    
    _refreshHeader.beginRefreshingBlock=^(){
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf headerRefreshAction];
    };
    
     /*是否在进入该界面的时候就开始进入刷新状态*/
    [_refreshHeader beginRefreshing];
    
    

    /* YiRefreshFooter  底部刷新按钮的使用 */
    _refreshFooter=[[YiRefreshFooter alloc] init];
    _refreshFooter.scrollView=_tableView;
    [_refreshFooter footer];
    
    _refreshFooter.beginRefreshingBlock=^(){
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf footerRefreshAction];
    };
    
}






//刷新
- (void)headerRefreshAction
{
     __weak typeof(self) weakSelf = self;
    [_tableViewModel headerRefreshRequestWithCallback:^(NSArray *array){
        __strong typeof(self) strongSelf = weakSelf;
        
        //把加载中视图从vc中移除，并显示tableview
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
            [strongSelf.loading removeFromSuperview];
            [strongSelf.view addSubview:strongSelf.tableView];
        });
        
        _totalSource=(NSMutableArray *)array;
        _tableViewModel.array = array;
        [_refreshHeader endRefreshing]; //结束刷新
        [_tableView reloadData]; //加载数据源
    }];

}


//加载更多
- (void)footerRefreshAction
{
    [_tableViewModel footerRefreshRequestWithCallback:^(NSArray *array){
        [_totalSource addObjectsFromArray:array] ; //追加数据
        _tableViewModel.array = _totalSource;
        [_refreshFooter endRefreshing];//结束加载
        [_tableView reloadData];//刷新数据源
    
    }];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end
