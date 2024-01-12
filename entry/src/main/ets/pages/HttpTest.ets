
import { FoodDetailData, FoodItemData } from '../data/Food';
import { getFoodDetail, getFoodsList, getFoodsListByCategory, getFoodsListByName } from '../data/FoodRequest';
import { createDiet, createExercise, delDiet, delExercise, getDietsDetailList, getDietsList, getExerciseDetailList, getExercisesList, updateDiet, updateExercise } from '../data/RecordRequest';
import { SportDetailData, SportItemData } from '../data/Sport';
import { getSportDetail, getSportsList, getSportsListByCategory, getSportsListBySearch } from '../data/SportRequest';
@Entry
@Component
struct HttpTest {
  foodItem: FoodItemData
  foodDetail: FoodDetailData
  sportItem: SportItemData
  sportDetail: SportDetailData
  @State refresh: boolean = true
  @State img: string = ""

  build() {
    Scroll() {
      Column() {
        Text("获取全部食物")
          .onClick(() => {
            getFoodsList()
              .then(res => {
                console.info('HttpTestResult_res1:' + res);
              }).catch(err => {
              console.error(err)
            })
          })
        Text("获取分类食物")
          .onClick(() => {
            getFoodsListByCategory(1).then(res => {
              console.info('HttpTestResult_res2:' + res);
            }).catch(err => {
              console.error(err)
            })
          })

        Text("搜索食物")
          .onClick(() => {
            getFoodsListByName("牛奶").then(res => {
              console.info('HttpTestResult_res3:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
        Text("获取食物详细信息")
          .onClick(() => {
            getFoodDetail("肉饼1").then(res => {
              let tmp : FoodDetailData = JSON.parse(JSON.parse(res as string))
              console.info('HttpTestResult_res4:' + tmp.name + tmp.fibre + tmp.protein)
              console.info('HttpTestResult_res4:' + res);
              this.foodDetail = tmp
              this.img = tmp.image
              console.log('HttpTestResult_res4:' + this.img);
              this.refresh = false
            }).catch(err => {
              console.error(err)
            })
          })

        Image(this.img == "" ? $r('app.media.blueberry') : 'data:image/jpeg;base64,' + this.img)

        Text("获取全部运动")
          .onClick(() => {
            getSportsList().then(res => {
              console.info('HttpTestResult_res5:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
        Text("获取分类运动")
          .onClick(() => {
            getSportsListByCategory(2).then(res => {
              console.info('HttpTestResult_res6:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
        Text("搜索运动")
          .onClick(() => {
            getSportsListBySearch("跑步").then(res => {
              console.info('HttpTestResult_res7:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
        Text("获取运动详情")
          .onClick(() => {
            getSportDetail("跑步").then(res => {
              console.info('HttpTestResult_res8:' + res);
            }).catch(err => {
              console.error(err)
            })
          })


        Text("获取全部食物记录")
          .onClick(() => {
            getDietsList("2024-1-11")
              .then(res => {
              console.info('HttpTestResult_res9:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
        Text("获取详细食物记录")
          .onClick(() => {
            getDietsDetailList("2024-1-11", "早餐", "牛奶")
              .then(res => {
              console.info('HttpTestResult_res10:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
        Text("增加食物记录")
          .onClick(() => {
            createDiet( "牛奶", 66, "2024-1-11", "早餐")
              .then(res => {
              console.info('HttpTestResult_res11:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
        Text("修改食物记录")
          .onClick(() => {
            updateDiet("牛奶", 66, "2024-1-11", "早餐")
              .then(res => {
              console.info('HttpTestResult_res12:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
        Text("删除食物记录")
          .onClick(() => {
            delDiet("2024-1-11", "早餐", "牛奶")
              .then(res => {
              console.info('HttpTestResult_res13:' + res);
            }).catch(err => {
              console.error(err)
            })
          })

        Text("获取全部运动记录")
          .onClick(() => {
            getExercisesList("2024-1-11")
              .then(res => {
              console.info('HttpTestResult_res14:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
        Text("获取详细运动记录")
          .onClick(() => {
            getExerciseDetailList("2024-1-11", "跑步")
              .then(res => {
              console.info('HttpTestResult_res15:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
        Text("增加运动记录")
          .onClick(() => {
            createExercise("跑步", 66, "2024-1-11")
              .then(res => {
              console.info('HttpTestResult_res16:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
        Text("修改运动记录")
          .onClick(() => {
            updateExercise("2024-1-11", 66, "跑步")
              .then(res => {
              console.info('HttpTestResult_res17:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
        Text("删除运动记录")
          .onClick(() => {
            delExercise("2024-1-11", "跑步")
              .then(res => {
              console.info('HttpTestResult_res18:' + res);
            }).catch(err => {
              console.error(err)
            })
          })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(HorizontalAlign.Center)
    }
    .scrollable(ScrollDirection.Vertical)
    .height("100%")
  }
}