
import thermal from '@ohos.thermal'
import ArrayList from '@ohos.util.ArrayList'
import router from '@ohos.router'
import { forEachTS } from '../../model/UtilTs'
import { FoodDetailData } from '../../data/Food'
import { RecordDietDetailData, RecordDietItemData, RecordHealthStateData, RecordSportItemData } from '../../data/Record'
import { getDietsDetailList, getDietsList, getExerciseDetailList, getExercisesList, getHealthState, updateDiet, updateExercise } from '../../data/RecordRequest'


export function DateToString (date: Date) : string {
  return date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate()
}

function GetRecordDietsDataMock(name: string) : RecordDietDetailData {

  return {
    id: 1,
    foodName: "牛奶",
    image: "",
    grams: 66,
    meal: "早餐",
    totalKcal: 66,
    totalCarbs: 66,
    totalFat: 66,
    totalFibre: 66,
    totalProtein: 66
  };
}

@CustomDialog
struct FoodRecordDialog {

  controller: CustomDialogController
  cancel: () => void
  confirm: () => void
  dietName: string = ""
  dietDetail: RecordDietDetailData = GetRecordDietsDataMock(this.dietName);
  @Link refresh: boolean
  @Link value: number

  tmpGrams: number = 0

  @State isKeyboard : boolean = false

  build() {
    Column() {
      Row() {
        Text(this.dietDetail.meal)
          .fontSize(24)
      }
      .margin("5%")

      Column() {
        Image('data:image/jpeg;base64,' + this.dietDetail.image)
          .width("20%")
          .height("10%")
        Text(this.dietDetail.foodName)
      }

      Column() {
        Divider().vertical(false).strokeWidth(1).margin("2%")
        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.SpaceAround,
          alignItems: ItemAlign.Center
        }) {
          Column() {
            Text("热量")
            Text(this.dietDetail.totalKcal + "")
          }

          Column() {
            Text("碳水")
            Text(this.dietDetail.totalCarbs.toString())
          }

          Column() {
            Text("蛋白质")
            Text(this.dietDetail.totalProtein.toString())
          }

          Column() {
            Text("脂肪")
            Text(this.dietDetail.totalFat.toString())
          }
        }
        Divider().vertical(false).strokeWidth(1).margin("2%")
      }
      .margin({top: "10%"})

      Row() {
        Column() {
          Text(this.isKeyboard == true ? "滑尺" : "键盘")
            .fontSize(20)
            .width("80%")
            .backgroundColor("#B8FFBC")
            .padding("5%")
            .textAlign(TextAlign.Center)
            .borderRadius(10)
            .onClick(() => {
              if (this.isKeyboard == false) {
                this.isKeyboard = true
              } else {
                this.isKeyboard = false
              }
            })
        }
        .width("30%")
        .justifyContent(FlexAlign.Center)

        Column() {
          if (this.isKeyboard == true) {
            TextInput({placeholder: "请输入数量"})
          } else {
            TextPicker({range: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'], selected: 0})
              .onChange((value: string, index: number) => {
                this.tmpGrams = parseInt(value)
                console.info('Picker item changed, value: ' + value + ', index: ' + index)
              })
              .defaultPickerItemHeight("50%")
              .width("100%")
              .backgroundColor('rgba(255, 255, 255, 0.5)')
          }
        }
        .height("100%")
        .width("40%")
        .justifyContent(FlexAlign.Center)


        Text("百克")
          .fontSize(24)
          .width("30%")
          .textAlign(TextAlign.Center)
      }
      .height("30%")
      .width("100%")
      .alignItems(VerticalAlign.Center)

      Row() {
        Text("保存")
          .fontSize(24)
          .width("60%")
          .backgroundColor("#B8FFBC")
          .padding("2%")
          .textAlign(TextAlign.Center)
          .borderRadius(20)
          .onClick(() => {
            updateDiet(this.dietDetail.foodName, this.tmpGrams * 100, DateToString(new Date()), this.dietDetail.meal)
            this.controller.close()
            this.confirm()
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.Center)

    }
    .height("80%")
    .width("100%")
    .backgroundColor('#ECFFEB')
  }
}

@Component
export struct FoodRecordItemCard {
  recordDietItemInfo: RecordDietItemData = null
  recordDietDetail: RecordDietDetailData = new RecordDietDetailData()
  @State value: number = this.recordDietDetail.grams

  @State refresh: boolean = true

  dialogController: CustomDialogController = new CustomDialogController({
    builder: FoodRecordDialog({
      cancel: this.onCancel,
      confirm: this.onAccept,
      dietDetail: this.recordDietDetail,
      refresh: $refresh,
      value: $value
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
    if (this.refresh) {
      Row() {
        Image('data:image/jpeg;base64,' + this.recordDietItemInfo.image)
          .width("10%")
        Column() {
          Text(this.recordDietItemInfo.foodName)
          Text(this.recordDietItemInfo.grams + "克")
            .fontSize(12)
            .fontColor(Color.Gray)
            .margin({top: "1%"})
        }
        .width("60%")
        .alignItems(HorizontalAlign.Start)
        .padding("2%")

        Text(this.recordDietItemInfo.totalKcal + "千卡")

        Image($r('app.media.ic_forward'))
          .width("5%")
          .margin({left: "5%"})
      }
      .width("100%")
      .margin({top: "5%"})
      .onClick(() => {
        let date = DateToString(new Date())
        getDietsDetailList(date, this.recordDietItemInfo.meal, this.recordDietItemInfo.foodName)
          .then(res => {
            this.recordDietDetail = JSON.parse(JSON.parse(res as string))
            console.info("recordDietDetail: " + this.recordDietDetail.foodName)
            this.dialogController.open()
          }).catch(err => {
          console.info("recordDietDetail: " + err)
        })
      })
    }
    else {
      Row() {
        Image('data:image/jpeg;base64,' + this.recordDietItemInfo.image)
          .width("10%")
        Column() {
          Text(this.recordDietItemInfo.foodName)
          Text(this.recordDietItemInfo.grams + "克")
            .fontSize(12)
            .fontColor(Color.Gray)
            .margin({top: "1%"})
        }
        .width("60%")
        .alignItems(HorizontalAlign.Start)
        .padding("2%")

        Text(this.recordDietItemInfo.totalKcal + "千卡")

        Image($r('app.media.ic_forward'))
          .width("5%")
          .margin({left: "5%"})
      }
      .width("100%")
      .margin({top: "5%"})
      .onClick(() => {
        let date = DateToString(new Date())
        getDietsDetailList(date, this.recordDietItemInfo.meal, this.recordDietItemInfo.foodName)
          .then(res => {
            this.recordDietDetail = JSON.parse(JSON.parse(res as string))
            console.info("recordDietDetail: " + this.recordDietDetail.foodName)
            this.dialogController.open()
          }).catch(err => {
          console.info("recordDietDetail: " + err)
        })
      })
    }


  }
}

@CustomDialog
struct SportRecordDialog {

  controller: CustomDialogController
  cancel: () => void
  confirm: () => void
  sportDetail: RecordSportItemData = null;
  tmpMin: number

  @State isKeyboard : boolean = false

  build() {
    Column() {
      Row() {
        Text('运动')
          .fontSize(24)
      }
      .margin("5%")

      Column() {
        Image('data:image/jpeg;base64,' + this.sportDetail.image)
          .width("20%")
          .height("10%")
        Text(this.sportDetail.sportName)
      }

      Column() {
        Divider().vertical(false).strokeWidth(1).margin("2%")
        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.SpaceAround,
          alignItems: ItemAlign.Center
        }) {

          Column() {
            Text("能量")
            Text(this.sportDetail.totalEnergy.toString() + "千卡/60分钟")
          }
        }
        Divider().vertical(false).strokeWidth(1).margin("2%")
      }
      .margin({top: "10%"})

      Row() {
        Column() {
          Text(this.isKeyboard == true ? "滑尺" : "键盘")
            .fontSize(20)
            .width("80%")
            .backgroundColor("#B8FFBC")
            .padding("5%")
            .textAlign(TextAlign.Center)
            .borderRadius(10)
            .onClick(() => {
              if (this.isKeyboard == false) {
                this.isKeyboard = true
              } else {
                this.isKeyboard = false
              }
            })
        }
        .width("30%")
        .justifyContent(FlexAlign.Center)

        Column() {
          if (this.isKeyboard == true) {
            TextInput({placeholder: "请输入数量"})
          } else {
            TextPicker({range: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'], selected: 0})
              .onChange((value: string, index: number) => {
                this.tmpMin = parseInt(value)
                console.info('Picker item changed, value: ' + value + ', index: ' + index)
              })
              .defaultPickerItemHeight("50%")
              .width("100%")
              .backgroundColor('rgba(255, 255, 255, 0.5)')
          }
        }
        .height("100%")
        .width("40%")
        .justifyContent(FlexAlign.Center)


        Text("30分钟")
          .fontSize(24)
          .width("30%")
          .textAlign(TextAlign.Center)
      }
      .height("30%")
      .width("100%")
      .alignItems(VerticalAlign.Center)

      Row() {
        Text("保存")
          .fontSize(24)
          .width("60%")
          .backgroundColor("#B8FFBC")
          .padding("2%")
          .textAlign(TextAlign.Center)
          .borderRadius(20)
          .onClick(() => {
            updateExercise(DateToString(new Date()), this.tmpMin * 30, this.sportDetail.sportName)
            this.controller.close()
            this.confirm()
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.Center)

    }
    .height("80%")
    .width("100%")
    .backgroundColor('#ECFFEB')
  }
}

@Component
export struct SportRecordItemCard {
  recordSportItemInfo: RecordSportItemData = null
  recordDetail: RecordSportItemData = null

  dialogController: CustomDialogController = new CustomDialogController({
    builder: SportRecordDialog({
      cancel: this.onCancel,
      confirm: this.onAccept,
      sportDetail: this.recordDetail
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
    Row() {
      Image('data:image/jpeg;base64,' + this.recordSportItemInfo.image)
        .width("10%")
      Column() {
        Text(this.recordSportItemInfo.sportName)
        Text(this.recordSportItemInfo.minutes + "分钟")
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({top: "1%"})
      }
      .width("60%")
      .alignItems(HorizontalAlign.Start)
      .padding("2%")

      Text(this.recordSportItemInfo.totalEnergy + "千卡")

      Image($r('app.media.ic_forward'))
        .width("5%")
        .margin({left: "5%"})
    }
    .onClick(() => {
      let date = DateToString(new Date())
      getExerciseDetailList(date, this.recordSportItemInfo.sportName).then(res => {
        this.recordDetail = JSON.parse(JSON.parse(res as string))
        this.dialogController.open()
      })
    })
    .width("100%")
    .margin({top: "5%"})
  }
}


export function GetRecordItemDataMock() : RecordDietItemData {

  return {
    id: 1,
    foodName: "牛奶",
    image: "",
    grams: 66,
    totalKcal: 66,
    meal: "早餐"
  };
}

@Entry
@Component
struct RecordPage {

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

  @State stateInfo: RecordHealthStateData = new RecordHealthStateData()
  @State breakfastInfo: RecordDietItemData[] = []
  @State lunchInfo: RecordDietItemData[] = []
  @State dinnerInfo: RecordDietItemData[] = []
  @State sportInfo: RecordSportItemData[] = []

  currentDate: Date = new Date()

  @State currentDateStr: string = DateToString(this.currentDate)
  @State currentDay: number = this.currentDate.getDay()

  @State dietLoading: boolean = true

  @State sportLoading: boolean = true

  @State stateLoading: boolean = true

  @State refresh: boolean = true

  onPageShow() {
    this.dietLoading = true
    this.sportLoading = true
    this.stateLoading = true

    this.breakfastInfo = []
    this.lunchInfo = []
    this.dinnerInfo = []
    this.sportInfo = []

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
      let obj : RecordSportItemData[] = JSON.parse(str)
      this.recordSportInfo = obj

      for (let index = 0; index < this.recordSportInfo.length; index++) {
        this.sportInfo.push(this.recordSportInfo[index]);
      }

      this.sportLoading = false
    })

    getHealthState(DateToString(new Date()))
      .then(res => {
        this.stateInfo = JSON.parse(JSON.parse(res as string))
        this.stateLoading = false
      })
  }

  build() {
    Column() {
      Flex({
        direction: FlexDirection.Row,
        justifyContent: FlexAlign.SpaceBetween,
        alignItems: ItemAlign.Center,
      }) {
        Image($r('app.media.back'))
          .width("10%")
          .onClick(() => {
            router.back()
          })

        Row() {
          Text(this.currentDateStr)
            .fontSize(20)
            .decoration({
              type: TextDecorationType.Underline,
              color: Color.Black
            })
            .padding("2%")
            .onClick(() => {
              DatePickerDialog.show({
                start: new Date("2000-1-1"),
                end: new Date("2100-1-1"),
                selected: this.currentDate,
                lunar: false,
                onAccept: (value: DatePickerResult) => {
                  this.currentDate.setFullYear(value.year, value.month, value.day)
                  this.currentDateStr = DateToString(this.currentDate)
                  this.currentDay = this.currentDate.getDay()

                  this.dietLoading = true
                  this.sportLoading = true
                  this.stateLoading = true

                  this.breakfastInfo = []
                  this.lunchInfo = []
                  this.dinnerInfo = []
                  this.sportInfo = []

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
                    let obj : RecordSportItemData[] = JSON.parse(str)
                    this.recordSportInfo = obj

                    for (let index = 0; index < this.recordSportInfo.length; index++) {
                      this.sportInfo.push(this.recordSportInfo[index]);
                    }

                    this.sportLoading = false
                  })

                  getHealthState(this.currentDateStr)
                    .then(res => {
                      this.stateInfo = JSON.parse(JSON.parse(res as string))
                      this.stateLoading = false
                    })
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
          Text(this.weekStr[this.currentDay])
            .fontSize(20)
        }
        .width("100%")
        .justifyContent(FlexAlign.Center)

        Image($r('app.media.ic_setting')).width("10%")
      }
      .margin("5%")

      Scroll() {
        Column() {
          if (this.stateLoading == false) {
            Swiper() {
              Column() {
                Row() {
                  Column() {
                    Text("饮食摄入").width("100%").textAlign(TextAlign.Center)
                    Text(this.stateInfo.inKcal.toFixed()).width("100%").textAlign(TextAlign.Center)
                  }.width("20%")

                  Stack() {
                    Progress({ value: this.stateInfo.inKcal, total: 3000, type: ProgressType.Ring })
                      .width("90%")
                      .style({ strokeWidth: 10 })
                      .margin("10%")
                    Column() {
                      Text("还可以吃").width("100%").textAlign(TextAlign.Center)
                      Text((3000 - parseInt(this.stateInfo.inKcal.toFixed())).toString()).width("100%").textAlign(TextAlign.Center)
                    }
                  }.width("50%")

                  Column() {
                    Text("运动消耗").width("100%").textAlign(TextAlign.Center)
                    Text(this.stateInfo.outKcal.toFixed()).width("100%").textAlign(TextAlign.Center)
                  }.width("20%")
                }

                Column() {
                  Row() {
                    Column() {
                      Text("碳水化合物")
                        .fontSize(14)
                      Text(this.stateInfo.carbs.toFixed() + "克")
                        .fontSize(12)
                    }
                    .width("40%")

                    Column() {
                      Text("蛋白质")
                        .fontSize(14)
                      Text(this.stateInfo.protein.toFixed() + "克")
                        .fontSize(12)
                    }
                    .width("40%")
                  }
                  .width("100%")
                  .justifyContent(FlexAlign.SpaceAround)

                  Row().height("5%")

                  Row() {
                    Column() {
                      Text("脂肪")
                        .fontSize(14)
                      Text(this.stateInfo.fat.toFixed() + "克")
                        .fontSize(12)
                    }
                    .width("40%")

                    Column() {
                      Text("纤维")
                        .fontSize(14)
                      Text(this.stateInfo.fibre.toFixed() + "克")
                        .fontSize(12)
                    }
                    .width("40%")
                  }
                  .width("100%")
                  .justifyContent(FlexAlign.SpaceAround)
                }
                .padding("5%")
                .justifyContent(FlexAlign.SpaceAround)
                .margin({bottom: "10%"})
              }
            }
            .height("45%")
            .width("90%")
            .margin("5%")
            .borderRadius(10)
            .backgroundColor('rgba(255, 255, 255, 0.8)')
          }


          if (this.dietLoading == false) {
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
          }

          if (this.sportLoading == false) {
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
                ForEach(this.sportInfo, (item: RecordSportItemData) => {
                  SportRecordItemCard({recordSportItemInfo: item})
                })
              }
              .width("90%")
              .margin("5%")
              .backgroundColor('rgba(255, 255, 255, 0.8)')
              .borderRadius(10)
              .padding("5%")
            }
          }

          Column().height("20%")
        }

      }
      .scrollable(ScrollDirection.Vertical)
      .edgeEffect(EdgeEffect.Spring)
      .height("100%")
      .backgroundColor('rgba(0, 0, 0, 0.1)')
    }
    .backgroundColor("#B8FFBC")
    .width("100%")
    .height("100%")
  }
}