
import router from '@ohos.router'
import { UserRegister } from '../data/UserRequest'

@Entry
@Component
struct Register {

  @State userName: string = ""
  @State passwd: string = ""
  @State confirmPasswd: string = ""
  @State currentWeight: number = 0
  @State goalWeight: number = 0
  @State phoneNumber: string = ""

  build() {
    Column() {
      Row() {
        Image($r('app.media.back'))
          .width("10%")
          .padding("1%")
          .onClick(() => {
            router.back()
          })
        Text("注册账号")
          .fontSize(20)
          .margin({left: "5%"})
      }
      .backgroundColor("#B8FFBC")
      .width("100%")
      .padding("2%")


      Column() {
        Column() {
          Text("用户名")
            .padding("5%")
            .width("100%")
          TextInput({placeholder: "请输入用户名"})
            .onChange((value: string) => {
              this.userName = value
            })
        }

        Column() {
          Text("密码")
            .padding("5%")
            .width("100%")
          TextInput({placeholder: "请输入密码"})
            .onChange((value: string) => {
              this.passwd = value
            })
        }

        Column() {
          Text("确认密码")
            .padding("5%")
            .width("100%")
          TextInput({placeholder: "请再次输入密码"})
            .onChange((value: string) => {
              this.confirmPasswd = value
            })
        }

        Column() {
          Text("当前体重")
            .padding("5%")
            .width("100%")
          TextInput({placeholder: "请输入当前体重"})
            .onChange((value: string) => {
              this.currentWeight = parseInt(value)
            })
        }

        Column() {
          Text("目标体重")
            .padding("5%")
            .width("100%")
          TextInput({placeholder: "请输入目标体重"})
            .onChange((value: string) => {
              this.goalWeight = parseInt(value)
            })
        }

        Column() {
          Text("手机号")
            .padding("5%")
            .width("100%")
          TextInput({placeholder: "请输入手机号"})
            .onChange((value: string) => {
              this.phoneNumber = value
            })
        }
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width("80%")
      .margin({top: "5%"})


      Row() {
        Text("立即注册")
          .fontSize(24)
          .width("60%")
          .textAlign(TextAlign.Center)
          .padding("2%")
          .backgroundColor("#B8FFBC")
          .borderRadius(20)
          .onClick(() => {
            UserRegister(this.userName, this.passwd, this.phoneNumber, this.currentWeight, this.goalWeight)
            router.back()
          })
      }
      .justifyContent(FlexAlign.Center)
      .width("100%")
      .margin({top: "10%"})
    }
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#ECFFEB')
    .height("100%")

  }
}