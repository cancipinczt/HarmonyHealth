import http from '@ohos.net.http';
let url ="http://172.19.139.217:80"
// let url ="http://172.31.26.30:80"
export function UserRegister(
    userName: string,
    passwd: string,
    phoneNumber: string,
    currWeight: number,
    goalWeight: number
) {
  let foodListRequest = http.createHttp()
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/user/register",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        extraData: {
          "userName": userName,
          "passwd": passwd,
          "phoneNumber": phoneNumber,
          "currWeight": currWeight,
          "goalWeight": goalWeight,
        },
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('UserRegister:' + data.result);
        let res = JSON.stringify(data.result)
        foodListRequest.destroy();
        resolve(res)
      } else {
        console.info('error:' + JSON.stringify(err));
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        foodListRequest.destroy();
        reject(err)
      }
    }
    );
  })
}

export function UserLogin(userName: string, passwd: string) {
  let foodListRequest = http.createHttp()
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/user/login",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        extraData: {
          "userName": userName,
          "passwd": passwd,
        },
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('UserLogin:' + data.result);
        let res = JSON.stringify(data.result)
        foodListRequest.destroy();
        resolve(res)
      } else {
        console.info('error:' + JSON.stringify(err));
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        foodListRequest.destroy();
        reject(err)
      }
    }
    );
  })
}

export function updateUserInfo(userName: string,
                               phoneNumber: string,
                               gender: string,
                               birth: string,
                               signature: string,
                               photo: string) {
  let foodListRequest = http.createHttp()
  let userId : number = AppStorage.Get('userId')
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/user/" + userId,
      {
        method: http.RequestMethod.PUT, // 可选，默认为http.RequestMethod.GET
        extraData: {
          "userName": userName,
          "phoneNumber": phoneNumber,
          "gender": gender,
          "birth": birth,
          "signature": signature,
          "photo": photo
        },
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('updateUserInfo:' + data.result);
        let res = JSON.stringify(data.result)
        foodListRequest.destroy();
        resolve(res)
      } else {
        console.info('error:' + JSON.stringify(err));
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        foodListRequest.destroy();
        reject(err)
      }
    }
    );
  })
}

export function getUserInfo() {
  let foodListRequest = http.createHttp()
  let userId : number = AppStorage.Get('userId')
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/user/" + userId,
      {
        method: http.RequestMethod.GET, // 可选，默认为http.RequestMethod.GET
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('getUserInfo:' + data.result);
        let res = JSON.stringify(data.result)
        foodListRequest.destroy();
        resolve(res)
      } else {
        console.info('error:' + JSON.stringify(err));
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        foodListRequest.destroy();
        reject(err)
      }
    }
    );
  })
}

export function updateGoal(goalWeight: number,
                           currentWeight: number,
                           startWeight: number,
                           startDate: string,
                           endDate: string
) {
  let foodListRequest = http.createHttp()
  let userId : number = AppStorage.Get('userId')
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/goal/" + userId,
      {
        method: http.RequestMethod.PUT, // 可选，默认为http.RequestMethod.GET
        extraData: {
          "goalWeight": goalWeight,
          "currWeight": currentWeight,
          "startWeight": startWeight,
          "startDate": startDate,
          "endDate": endDate
        },
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('updateGoal:' + currentWeight)
        console.info('updateGoal:' + data.result);
        let res = JSON.stringify(data.result)
        foodListRequest.destroy();
        resolve(res)
      } else {
        console.info('error:' + JSON.stringify(err));
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        foodListRequest.destroy();
        reject(err)
      }
    }
    );
  })
}

export function getGoal() {
  let foodListRequest = http.createHttp()
  let userId : number = AppStorage.Get('userId')
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/goal/" + userId,
      {
        method: http.RequestMethod.GET, // 可选，默认为http.RequestMethod.GET
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('getFoodResult:' + data.result);
        let res = JSON.stringify(data.result)
        foodListRequest.destroy();
        resolve(res)
      } else {
        console.info('error:' + JSON.stringify(err));
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        foodListRequest.destroy();
        reject(err)
      }
    }
    );
  })
}



export function AIChat(question: string) {
  let foodListRequest = http.createHttp()
  let chartId : number = AppStorage.Get('chartId')
  console.info('AIChartResult:' + chartId);
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/chat/",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        extraData: {
          "chatId": chartId,
          "question": question
        }
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('AIChartResult:' + question);
        console.info('AIChartResult:' + data.result);
        let res = JSON.stringify(data.result)
        foodListRequest.destroy();
        resolve(res)
      } else {
        console.info('error:' + JSON.stringify(err));
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        foodListRequest.destroy();
        reject(err)
      }
    }
    );
  })
}
