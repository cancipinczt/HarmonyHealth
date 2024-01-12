
import router from '@ohos.router'
import { FoodDetailData, FoodItemData } from '../../data/Food'
import { getFoodDetail, getFoodsListByName } from '../../data/FoodRequest'
import { FoodDetailDialog, GetFoodsMock } from './FoodPage'

@Entry
@Component
struct FoodSearch {
  controller: SearchController = new SearchController()
  private foodItems: FoodItemData[] = []
  @State refresh: boolean = true
  foodDetail: FoodDetailData = null

  dialogController: CustomDialogController = new CustomDialogController({
    builder: FoodDetailDialog({
      cancel: this.onCancel,
      confirm: this.onAccept,
      foodInfo: this.foodDetail
    }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false
  })

  aboutToDisappear() {
    this.dialogController = undefined // 将dialogController置空
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  existApp() {
    console.info('Click the callback in the blank area')
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_top_back'))
          .onClick(() => {
            console.info(`Succeeded in clicking the 'Back' button.`)
            try {
              // 返回第一页
              router.back()
              console.info('Succeeded in returning to the first page.')
            } catch (err) {
              console.error(`Failed to return to the first page.Code is ${err.code}, message is ${err.message}`)
            }
          })
          .width("10%")
        Search({ placeholder: 'Search', controller: this.controller })
          .searchButton('搜索')
          .width(400)
          .height(40)
          .backgroundColor(Color.White)
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .width("90%")
          .onSubmit((value) => {
            getFoodsListByName(value)
              .then(res => {
              this.foodItems = JSON.parse(JSON.parse(res as string))
              this.refresh = !this.refresh
            })
          })
      }
      .height("10%")

      if (this.refresh == true) {
        List() {
          ForEach(this.foodItems, (item: FoodItemData) => {
            ListItem() {
              Row() {
                Text(item.name).textAlign(TextAlign.Start).width("50%")
                Text(item.kcal.toString() + "千卡").textAlign(TextAlign.End).width("50%")
              }
            }.margin("5%")
            .onClick(() => {
              getFoodDetail(item.name).then(res => {
                this.foodDetail = JSON.parse(JSON.parse(res as string))
                if (this.dialogController != undefined) {
                  this.dialogController.open()
                }
              })
            })
          })
        }
        .height("80%")
        .width("100%")
      }
      else {
        List() {
          ForEach(this.foodItems, (item: FoodItemData) => {
            ListItem() {
              Row() {
                Text(item.name).textAlign(TextAlign.Start).width("50%")
                Text(item.kcal.toString() + "千卡").textAlign(TextAlign.End).width("50%")
              }
            }.margin("5%")
            .onClick(() => {
              getFoodDetail(item.name).then(res => {
                this.foodDetail = JSON.parse(JSON.parse(res as string))
                if (this.dialogController != undefined) {
                  this.dialogController.open()
                }
              })
            })
          })
        }
        .height("80%")
        .width("100%")
      }
    }
    .height("100%")
    .backgroundColor("#B8FFBC")
  }
}