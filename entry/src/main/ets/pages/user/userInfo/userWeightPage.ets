
import router from '@ohos.router'
import { UserWeightGoal } from '../../../data/User'
import { getGoal, updateGoal } from '../../../data/UserRequest'

@CustomDialog
struct WeightDetailDialog {

  controller: CustomDialogController
  cancel: () => void
  confirm: () => void

  name: string
  @Link content: number
  tmpContent: number
  build() {
    Column() {
      Text('修改' + this.name)
        .fontSize(30)
      TextInput()
        .type(InputType.Number)
        .width("80%")
        .onChange((value: string) => {
          this.tmpContent = parseInt(value)
        })
      Row() {
        Text('取消')
          .fontSize(20)
          .onClick(() => {
            this.controller.close()
            this.cancel()
          })
        Text('确定')
          .fontSize(20)
          .onClick(() => {
            this.content = this.tmpContent
            console.info('ConfirmDialog: ' + this.content)
            this.controller.close()
            this.confirm()
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .height("40%")
    .width("100%")
    .justifyContent(FlexAlign.SpaceEvenly)
    .backgroundColor('#ECFFEB')
  }
}

@Component
struct InfoListItem {
  name: string
  @Prop info: string

  build() {
    Row() {
      Text(this.name)
        .width("20%")
      Text(this.info)
        .width("70%")
        .fontColor('rgba(0, 0, 0, 0.6)')
        .textAlign(TextAlign.End)
      Image($r('app.media.ic_forward')).width("5%").margin({left: "5%"})
    }
    .margin("5%")
  }
}

@Entry
@Component
struct UserWeight {
  @State startWeight: number = 0
  @State targetWeight: number = 0
  @State currentWeight: number = 0
  @State startDate: string = '2024-1-11'
  @State targetDate: string = '2024-1-11'
  @State dialogTittle: string = ""
  @State dialogContent: number = 0
  @State loading: boolean = true

  weightInfo: UserWeightGoal = new UserWeightGoal()

  startWeightDialogController: CustomDialogController = new CustomDialogController({
    builder: WeightDetailDialog({
      cancel: this.onCancel,
      confirm: this.onAccept,
      name: '初始体重',
      content: $startWeight
    }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false
  })

  targetWeightDialogController: CustomDialogController = new CustomDialogController({
    builder: WeightDetailDialog({
      cancel: this.onCancel,
      confirm: this.onAccept,
      name: '目标体重',
      content: $targetWeight
    }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false
  })

  currentWeightDialogController: CustomDialogController = new CustomDialogController({
    builder: WeightDetailDialog({
      cancel: this.onCancel,
      confirm: this.onAccept,
      name: '当前体重',
      content: $currentWeight
    }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false
  })

  aboutToDisappear() {
    updateGoal(this.targetWeight, this.currentWeight, this.startWeight, this.startDate, this.targetDate)
    this.startWeightDialogController = undefined // 将dialogController置空
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

  aboutToAppear() {
    getGoal().then(res => {
      this.weightInfo = JSON.parse(JSON.parse(res as string))
      this.startWeight = this.weightInfo.startWeight
      this.currentWeight = this.weightInfo.currWeight
      this.targetWeight = this.weightInfo.goalWeight
      this.startDate = this.weightInfo.startDate
      this.targetDate = this.weightInfo.endDate
      this.loading = false
    })
  }


  build() {
    if (this.loading == true) {
      Text('加载中')
        .fontSize(24)
    } else {
      Column() {
        Row() {
          Image($r('app.media.back'))
            .width("10%")
            .margin({right: "5%", left: '2%'})
            .onClick(() => {
              console.info("updateGoal" + this.currentWeight)
              updateGoal(this.targetWeight, this.currentWeight, this.startWeight, this.startDate, this.targetDate)
              router.back()
            })
          Text('我的体重管理')
            .fontSize(24)
        }
        .height("10%")

        Row() {
          InfoListItem({name: '初始体重', info: this.startWeight.toString()})
            .onClick(() => {
              this.startWeightDialogController.open()
            })
        }
        Row() {
          InfoListItem({name: '初始日期', info: this.startDate == undefined ? '1970-1-1' : this.startDate})
            .onClick(() => {
              DatePickerDialog.show({
                start: new Date("2000-1-1"),
                end: new Date("2100-1-1"),
                selected: new Date(this.startDate),
                lunar: false,
                onAccept: (value: DatePickerResult) => {
                  this.startDate = value.year + "-" + (value.month + 1) + "-" + value.day
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
        }
        Row() {
          InfoListItem({name: '目标体重', info: this.targetWeight.toString()})
            .onClick(() => {
              this.targetWeightDialogController.open()
            })
        }
        Row() {
          InfoListItem({name: '目标日期', info: this.targetDate == undefined ? '1970-1-1' : this.targetDate})
            .onClick(() => {
              DatePickerDialog.show({
                start: new Date("2000-1-1"),
                end: new Date("2042-1-1"),
                selected: new Date(this.targetDate),
                lunar: false,
                onAccept: (value: DatePickerResult) => {
                  this.targetDate = value.year + "-" + (value.month + 1) + "-" + value.day
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
        }

        Row() {
          InfoListItem({name: '当前体重', info: this.currentWeight.toString()})
            .onClick(() => {
              this.currentWeightDialogController.open()
            })
        }
      }
      .width("100%")
      .height("100%")
      .backgroundColor("#ECFFEB")
      .alignItems(HorizontalAlign.Start)
    }
  }
}