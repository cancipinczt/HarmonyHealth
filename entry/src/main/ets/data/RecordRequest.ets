
import http from '@ohos.net.http';

let url ="http://172.19.139.217:80"
// let url ="http://172.31.26.30:80"

export function getDietsList(date: string) {
  let foodListRequest = http.createHttp()
  let userId : number = AppStorage.Get("userId")
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/diets",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "date": date,
          "userId": userId
        },
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

export function getDietsDetailList(date: string, meal: string, foodName: string) {
  let foodListRequest = http.createHttp()
  let userId: number = AppStorage.Get("userId")
  return new Promise((resolve, reject) => {
    console.info("getDietsDetailList: " + foodName)
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/diet-detail",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "date": date,
          "userId": userId,
          "meal": meal,
          "foodName": foodName
        },
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('getDietsDetailList:' + data.result);
        let res = JSON.stringify(data.result)
        foodListRequest.destroy();
        resolve(res)
      } else {
        console.info('getDietsDetailList_error:' + JSON.stringify(err));
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        foodListRequest.destroy();
        reject(err)
      }
    }
    );
  })
}

export function createDiet(foodName: string, grams: number, date: string, meal: string) {
  let foodListRequest = http.createHttp()
  let userId: number = AppStorage.Get("userId")
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/diet",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "foodName": foodName,
          "grams": grams,
          "date": date,
          "meal": meal,
          "userId": userId
        },
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('createDiet:' + data.result);
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

export function updateDiet(foodName: string, grams: number, date: string, meal: string) {
  let foodListRequest = http.createHttp()
  let userId: number = AppStorage.Get("userId")
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/diet",
      {
        method: http.RequestMethod.PUT, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "userId": userId,
          "date": date,
          "meal": meal,
          "foodName": foodName,
          "grams": grams
        },
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

export function delDiet(date: string, meal: string, foodName: string) {
  let foodListRequest = http.createHttp()
  let userId: number = AppStorage.Get("userId")
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/diet-delete",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "userId": userId,
          "date": date,
          "meal": meal,
          "foodName": foodName,
        },
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


export function getExercisesList(date: string) {
  let foodListRequest = http.createHttp()
  let userId: number = AppStorage.Get("userId")
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/exercises",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "date": date,
          "userId": userId
        },
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

export function getExerciseDetailList(date: string, sportName: string) {
  let foodListRequest = http.createHttp()
  let userId: number = AppStorage.Get("userId")
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/exercise-detail",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "date": date,
          "userId": userId,
          "sportName": sportName
        },
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

export function createExercise(sportName: string, minutes: number, date: string) {
  let foodListRequest = http.createHttp()
  let userId: number = AppStorage.Get("userId")
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/exercise",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "sportName": sportName,
          "minutes": minutes,
          "date": date,
          "userId": userId
        },
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

export function updateExercise(date: string, minutes: number, sportName: string) {
  let foodListRequest = http.createHttp()
  let userId: number = AppStorage.Get("userId")
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/exercise",
      {
        method: http.RequestMethod.PUT, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "userId": userId,
          "date": date,
          "minutes": minutes,
          "sportName": sportName,
        },
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

export function delExercise(date: string, sportName: string) {
  let foodListRequest = http.createHttp()
  let userId: number = AppStorage.Get("userId")
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/exercise-delete",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "userId": userId,
          "date": date,
          "sportName": sportName,
        },
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

export function getHealthState(date: string) {
  let foodListRequest = http.createHttp()
  let userId = AppStorage.Get("userId")
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/state",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "date": date,
          "userId": userId
        },
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('getHealthState:' + data.result);
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
