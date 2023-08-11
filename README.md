## MMChooseAddressView

 * 仿淘宝2023最新省市县街道选择器样式，交互逻辑大体与淘宝一致，数据源是自己模拟的，有需要的同学可以自行参考一下。
  
  
 * 初始化方法：
  
```
 #import "MMChooseAddressView.h"

  MMChooseAddressView *view = [[MMChooseAddressView alloc]init];
  view.delegate = self;
  [view show];
  
```




* 选择的结果代理方法：

```
MMAddressSelectedViewDelegate

//选中的结果
-(void)mmChooseAddressViewDidSelectedArr:(NSMutableArray *)selectedArr{

}

```

* 支持传入地址 

```
/*
 从外部传入 code 集合  逗号间隔 code1,code2,code3
 */
-(void)setCodesString:(NSString *)codes;

```