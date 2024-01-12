
import router from '@ohos.router'

@Entry
@Component
export struct UserNameEdit {

  @State tmpName: string = ""

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
                name: "无",
                info: this.tmpName
              }
            })
          })

        Text("修改昵称")
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
                name: "昵称",
                info: this.tmpName
              }
            })

            console.log("new name is " + this.tmpName)
          })
      }
      .backgroundColor("#B8FFBC")
      .width("100%")


      Row() {
        TextInput({placeholder: "请输入新昵称"})
          .fontSize(20)
          .onChange((value: string) => {
            this.tmpName = value
          })
      }
      .margin({top: "5%"})
    }
    .width("100%")
  }
}