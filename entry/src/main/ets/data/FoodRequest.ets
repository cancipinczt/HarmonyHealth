import http from '@ohos.net.http';

let url ="http://172.19.139.217:80"
// let url ="http://172.31.26.30:80"

export function getFoodsList() {
  let foodListRequest = http.createHttp()
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/foods",
      {
        method: http.RequestMethod.GET, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "name": "牛奶",
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

export function getFoodsListByCategory(category: number) {
  let foodListRequest = http.createHttp()
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/foods/" + category,
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

export function getFoodsListByName(name: string) {
  let foodListRequest = http.createHttp()
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/food/search",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        extraData: {
          "name": name,
        },
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('getFoodsListByName:');
        console.info('getFoodsListByName:' + data.result);
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

export function getFoodDetail (name: string) {
  let foodListRequest = http.createHttp()
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url + "/api/food",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "name": name,
        },
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('getFoodResult:');
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
