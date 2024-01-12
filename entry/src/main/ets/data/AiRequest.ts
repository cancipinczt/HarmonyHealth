
import http from '@ohos.net.http';

export function AIChatDir(question: string) {
  let foodListRequest = http.createHttp()
  let chartId : number = AppStorage.Get('chartId')
  console.info('AIChartResult:' + chartId);
  return new Promise((resolve, reject) => {
    foodListRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      "http://10.58.0.2:6678/v1/chat/completions",
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        extraData: {
          "model": "xxx",
          "max_tokens": 2048,
          "top_p": 1,
          "temperature": 1,
          "messages": [
            {
              "role": "system",
              "content": "You are a helpful assistant."
            },
            {
              "role": "user",
              "content": question
            }
          ]
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
