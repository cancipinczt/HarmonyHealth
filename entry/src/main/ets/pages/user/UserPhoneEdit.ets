


import router from '@ohos.router'

@Entry
@Component
export struct UserNameEdit {

  @State tmpNumber: string = ""

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
                info: this.tmpNumber
              }
            })
          })

        Text("修改电话号码")
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
                name: "电话号码",
                info: this.tmpNumber
              }
            })

            console.log("new name is " + this.tmpNumber)
          })
      }
      .backgroundColor("#B8FFBC")
      .width("100%")


      Row() {
        TextInput({placeholder: "请输入新号码"})
          .fontSize(20)
          .type(InputType.PhoneNumber)
          .onChange((value: string) => {
            this.tmpNumber = value
          })
      }
      .margin({top: "5%"})
    }
    .width("100%")
  }
}