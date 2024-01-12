
import { RecordDietItemData, RecordSportItemData } from '../../../data/Record'
import { getDietsList, getExercisesList } from '../../../data/RecordRequest'
import { FoodRecordItemCard, GetRecordItemDataMock } from '../../record/RecordPage'

export function DateToString (date: Date) {
  return date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate()
}

@Entry
@Component
struct myDiet {

  weekStr: string[] = [
    "星期日",
    "星期一",
    "星期二",
    "星期三",
    "星期四",
    "星期五",
    "星期六",
  ]

  recordDietInfo: RecordDietItemData[] = [
    GetRecordItemDataMock(),
    GetRecordItemDataMock(),
    GetRecordItemDataMock(),
  ]

  recordSportInfo: RecordSportItemData[] = []

  @State breakfastInfo: RecordDietItemData[] = []
  @State lunchInfo: RecordDietItemData[] = []
  @State dinnerInfo: RecordDietItemData[] = []
  @State sportInfo: RecordSportItemData[] = []
  @State currentDate: Date = new Date()

  @State currentDateStr: string = DateToString(this.currentDate)

  @State dietLoading: boolean = true

  @State sportLoading: boolean = true

  onPageShow() {

    getDietsList(this.currentDateStr).then(res => {
      let str = JSON.parse(res as string)
      console.info("FoodListInit:" + str)
      let obj : RecordDietItemData[] = JSON.parse(str)
      console.info("FoodListInit:" + obj)
      this.recordDietInfo = obj
      console.info("FoodListInit:" + str)
      console.info("FoodListInit1:" + this.recordDietInfo[0].foodName)

      for (let index = 0; index < this.recordDietInfo.length; index++) {
        if (this.recordDietInfo[index].meal == "早餐") {
          this.breakfastInfo.push(this.recordDietInfo[index]);
        }
        else if (this.recordDietInfo[index].meal == "午餐") {
          this.lunchInfo.push(this.recordDietInfo[index]);
        }
        else if (this.recordDietInfo[index].meal == "晚餐") {
          this.dinnerInfo.push(this.recordDietInfo[index]);
        }
      }
      this.dietLoading = false
    })

    getExercisesList(this.currentDateStr).then(res => {
      let str = JSON.parse(res as string)
      console.info("FoodListInit:" + str)
      let obj : RecordSportItemData[] = JSON.parse(str)
      console.info("FoodListInit:" + obj)
      this.recordSportInfo = obj
      console.info("FoodListInit:" + str)
      console.info("FoodListInit1:" + this.recordSportInfo[0].sportName)

      for (let index = 0; index < this.recordSportInfo.length; index++) {
        this.sportInfo.push(this.recordSportInfo[index]);
      }

      this.sportLoading = false
    })
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.back'))
          .width("10%")
          .margin({left: "5%"})
        Text("我的饮食")
          .fontSize(24)
          .margin({left: "5%"})
      }
      .height("10%")
      .padding("2%")
      .justifyContent(FlexAlign.Start)
      .width("100%")

      Row() {
        Text(DateToString(this.currentDate))
          .fontSize(20)
          .decoration({
            type: TextDecorationType.Underline,
            color: Color.Black
          })
          .padding("2%")
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date("2000-1-1"),
              end: new Date("2024-1-1"),
              selected: this.currentDate,
              lunar: false,
              onAccept: (value: DatePickerResult) => {
                this.currentDate.setFullYear(value.year, value.month, value.day)
                console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
              },
              onCancel: () => {
                console.info("DatePickerDialog:onCancel()")
              },
              onChange: (value: DatePickerResult) => {
                console.info("DatePickerDialog:onChange()" + JSON.stringify(value))
              }
            })
          })
        Text(this.weekStr[this.currentDate.getDay()])
          .fontSize(20)
      }
      .width("100%")
      .justifyContent(FlexAlign.Center)
      .height("10%")

      Scroll() {
        Column() {
          Swiper() {
            Column() {
              Row() {
                Column() {
                  Text("饮食摄入").width("100%").textAlign(TextAlign.Center)
                  Text("0").width("100%").textAlign(TextAlign.Center)
                }.width("20%")

                Stack() {
                  Progress({ value: 20, total: 100, type: ProgressType.Ring })
                    .width("90%")
                    .style({ strokeWidth: 10 })
                    .margin("10%")
                  Column() {
                    Text("还可以吃").width("100%").textAlign(TextAlign.Center)
                    Text("500").width("100%").textAlign(TextAlign.Center)
                  }
                }.width("50%")

                Column() {
                  Text("运动消耗").width("100%").textAlign(TextAlign.Center)
                  Text("999").width("100%").textAlign(TextAlign.Center)
                }.width("20%")
              }

              Flex({
                direction: FlexDirection.Row,
                justifyContent: FlexAlign.SpaceAround,
                alignItems: ItemAlign.Center
              }) {
                Column() {
                  Text("碳水化合物")
                    .fontSize(14)
                  Progress({ value: 120, total: 290, type: ProgressType.Linear })
                    .width("70%")
                    .margin("5%")
                  Text("120/290克")
                    .fontSize(12)
                }

                Column() {
                  Text("蛋白质")
                    .fontSize(14)
                  Progress({ value: 120, total: 290, type: ProgressType.Linear })
                    .width("70%")
                    .margin("5%")
                  Text("120/290克")
                    .fontSize(12)
                }

                Column() {
                  Text("脂肪")
                    .fontSize(14)
                  Progress({ value: 120, total: 290, type: ProgressType.Linear })
                    .width("70%")
                    .margin("5%")
                  Text("120/290克")
                    .fontSize(12)
                }
              }
              .margin({bottom: "10%"})
            }
          }
          .height("35%")
          .width("90%")
          .margin("5%")
          .borderRadius(10)
          .backgroundColor('rgba(255, 255, 255, 0.8)')

          if (this.breakfastInfo.length > 0) {
            Column() {
              Row() {
                Text("早餐")
                  .fontSize(24)
                Text("建议568-795千卡")
                  .fontSize(16)
                  .fontColor(Color.Gray)
                  .margin({left: "2%"})
                Row().width("15%")
                Text("569千卡")
                  .fontSize(12)
                Image($r('app.media.ic_forward'))
                  .width("5%")
                  .margin({left: "5%"})
              }
              .width("100%")
              ForEach(this.breakfastInfo, (item: RecordDietItemData) => {
                FoodRecordItemCard({recordDietItemInfo: item})
              })
            }
            .width("90%")
            .margin("5%")
            .backgroundColor('rgba(255, 255, 255, 0.8)')
            .borderRadius(10)
            .padding("5%")
          }

          if (this.lunchInfo.length > 0) {
            Column() {
              Row() {
                Text("午餐")
                  .fontSize(24)
                Text("建议795-1022千卡")
                  .fontSize(16)
                  .fontColor(Color.Gray)
                  .margin({left: "2%"})
                Row().width("15%")
                Text("569千卡")
                  .fontSize(12)
                Image($r('app.media.ic_forward'))
                  .width("5%")
                  .margin({left: "5%"})
              }
              .width("100%")
              ForEach(this.lunchInfo, (item: RecordDietItemData) => {
                FoodRecordItemCard({recordDietItemInfo: item})
              })
            }
            .width("90%")
            .margin("5%")
            .backgroundColor('rgba(255, 255, 255, 0.8)')
            .borderRadius(10)
            .padding("5%")
          }

          if (this.dinnerInfo.length > 0) {
            Column() {
              Row() {
                Text("晚餐")
                  .fontSize(24)
                Text("建议568-795千卡")
                  .fontSize(16)
                  .fontColor(Color.Gray)
                  .margin({left: "2%"})
                Row().width("15%")
                Text("569千卡")
                  .fontSize(12)
                Image($r('app.media.ic_forward'))
                  .width("5%")
                  .margin({left: "5%"})
              }
              .width("100%")
              ForEach(this.dinnerInfo, (item: RecordDietItemData) => {
                FoodRecordItemCard({recordDietItemInfo: item})
              })
            }
            .width("90%")
            .margin("5%")
            .backgroundColor('rgba(255, 255, 255, 0.8)')
            .borderRadius(10)
            .padding("5%")
          }

          if (this.sportInfo.length > 0) {
            Column() {
              Row() {
                Text("运动")
                  .fontSize(24)
                Text("建议568-795千卡")
                  .fontSize(16)
                  .fontColor(Color.Gray)
                  .margin({left: "2%"})
                Row().width("15%")
                Text("569千卡")
                  .fontSize(12)
                Image($r('app.media.ic_forward'))
                  .width("5%")
                  .margin({left: "5%"})
              }
              .width("100%")
              ForEach(this.sportInfo, (item: RecordDietItemData) => {
                FoodRecordItemCard({recordDietItemInfo: item})
              })
            }
            .width("90%")
            .margin("5%")
            .backgroundColor('rgba(255, 255, 255, 0.8)')
            .borderRadius(10)
            .padding("5%")
          }

          Column().height("10%")
        }

      }
      .scrollable(ScrollDirection.Vertical)
      .edgeEffect(EdgeEffect.Spring)
      .height("100%")
      .backgroundColor('rgba(0, 0, 0, 0.1)')
    }
    .backgroundColor("#B8FFBC")
  }
}