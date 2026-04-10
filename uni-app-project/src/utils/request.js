// #ifdef H5
import axios from 'axios'
// #endif

const BASE_URL = import.meta.env.VITE_API_BASE_URL || '/api'

// #ifdef H5
const service = axios.create({
  baseURL: BASE_URL,
  timeout: 15000
})

// 请求拦截器
service.interceptors.request.use(
  config => {
    const token = uni.getStorageSync('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  error => {
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(
  response => {
    return response.data
  },
  error => {
    return Promise.reject(error)
  }
)
// #endif

// #ifndef H5
// 小程序/APP 使用 uni.request 封装
const service = {
  request(options) {
    return new Promise((resolve, reject) => {
      uni.request({
        url: BASE_URL + options.url,
        method: options.method || 'GET',
        data: options.data || {},
        header: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${uni.getStorageSync('token')}`
        },
        success: (res) => {
          if (res.statusCode === 200) {
            resolve(res.data)
          } else {
            reject(res.data)
          }
        },
        fail: reject
      })
    })
  }
}
// #endif

export function request(options) {
  return service.request ? service.request(options) : service(options)
}