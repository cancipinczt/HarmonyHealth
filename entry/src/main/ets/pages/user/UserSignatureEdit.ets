
import router from '@ohos.router'
class DataModel {
  id: number
  info: string
}


@Entry
@Component
export struct UserNameEdit {

  @State tmpSignature: string = ""

  build() {

    Column() {
      Row() {
        Image($r('app.media.back'))
          .width("7%")
          .margin({left: "3%"})
          .onClick(() => {

          router.back({
            url: "pages/user/UserInfoEdit",
            params: {
              name: '无',
              info: this.tmpSignature
            }
          })
        })

        Text("修改个性签名")
          .width("40%")
          .fontSize(24)
          .margin("5%")
        Text("保存")
          .width("30%")
          .margin("5%")
          .textAlign(TextAlign.End)
          .fontSize(16)
          .onClick(() => {
            router.back({
              url: "pages/user/UserInfoEdit",
              params: {
                name: "个性签名",
                info: this.tmpSignature
              }
            })
          })
      }
      .backgroundColor("#B8FFBC")
      .width("100%")


      Row() {
        TextInput({placeholder: "请输入新个性签名"})
          .fontSize(20)
          .onChange((value: string) => {
            this.tmpSignature = value
          })
      }
      .margin({top: "5%"})
    }
    .width("100%")
  }
}