
import router from '@ohos.router'
import App from '@system.app'
import { LoginResponse, RegisterResponse } from '../data/User'
import { UserLogin } from '../data/UserRequest'

@Entry
@Component
struct Login {
  @State userName: string = ""
  @State passwd: string = ""
  @State loginFalse: boolean = false

  build() {
    Column() {
      Row() {
        Image($r('app.media.logo')).width("50%")
      }
      .margin({top: "20%"})

      Column() {
        Row() {
          Text("账号")
            .margin({right: "5%"})
            .fontWeight(FontWeight.Bold)
            .fontSize(20)
          TextInput({placeholder: "请输入账号"})
            .width("60%")
            .backgroundColor('rgba(255, 255, 255, 0.5)')
            .onChange((value: string) => {
              this.userName = value
            })
        }

        Row() {
          Text("密码")
            .margin({right: "5%"})
            .fontWeight(FontWeight.Bold)
            .fontSize(20)
          TextInput({placeholder: "请输入密码"})
            .type(InputType.Password)
            .width("60%")
            .backgroundColor('rgba(255, 255, 255, 0.5)')
            .onChange((value: string) => {
              this.passwd = value
            })
        }
        .margin({top: "10%"})

        Row() {
          Column() {
            Row() {
              Text("立即注册")
                .fontColor(Color.Blue)
                .onClick(() => {
                  router.pushUrl({ url: 'pages/Register' })
                })
            }

            Divider()
              .vertical(false)
              .strokeWidth(1)
              .color(Color.Blue)
              .width("20%")
          }
          .margin({right: "5%"})

          Button("登录")
            .width("40%")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
          .onClick(() => {

            UserLogin(this.userName, this.passwd).then(res => {
              let result: LoginResponse = JSON.parse(JSON.parse(res as string))
              if (result.permission == true) {
                AppStorage.SetOrCreate("userId", result.userId)
                AppStorage.SetOrCreate("chartId", 0)
                router.pushUrl({url: 'pages/Home'})
              } else {
                this.loginFalse = true
              }
            })
          })

          Column() {
            Row() {
              Text("忘记密码")
                .fontColor(Color.Blue)
                .onClick(() => {
                  router.pushUrl({url: "pages/HttpTest"})
                })
            }

            Divider()
              .vertical(false)
              .strokeWidth(1)
              .color(Color.Blue)
              .width("20%")
          }
          .margin({left: "5%"})
        }
        .margin({top: "20%"})

        if (this.loginFalse == true) {
          Text("用户名或密码错误")
        }

      }
      .margin({top: "20%"})
      .alignItems(HorizontalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
    .width("100%")
    .height("100%")
    .backgroundColor("#B8FFBC")
  }


}