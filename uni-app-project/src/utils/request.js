/**
 * 请求封装
 * H5 端使用 axios，小程序/APP 端使用 uni.request
 * 统一的请求方法和错误处理机制
 */

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
    console.error('请求错误:', error)
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(
  response => {
    return response.data
  },
  error => {
    handleError(error)
    return Promise.reject(error)
  }
)
// #endif

// #ifndef H5
// 小程序/APP 使用 uni.request 封装
const service = {
  request(options) {
    return new Promise((resolve, reject) => {
      // 请求拦截
      const token = uni.getStorageSync('token')
      const headers = {
        'Content-Type': 'application/json',
        ...options.headers
      }
      if (token) {
        headers.Authorization = `Bearer ${token}`
      }

      uni.request({
        url: BASE_URL + options.url,
        method: options.method || 'GET',
        data: options.data || {},
        header: headers,
        success: (res) => {
          if (res.statusCode === 200) {
            resolve(res.data)
          } else {
            const error = new Error(`HTTP ${res.statusCode}`)
            error.response = res
            handleError(error)
            reject(res.data)
          }
        },
        fail: (err) => {
          handleError(err)
          reject(err)
        }
      })
    })
  }
}
// #endif

/**
 * 统一错误处理
 * @param {Error} error - 错误对象
 */
function handleError(error) {
  console.error('请求错误:', error)
  
  // 网络错误
  if (!error.response) {
    uni.showToast({
      title: '网络连接失败',
      icon: 'none'
    })
    return
  }

  // HTTP 错误
  const status = error.response.status
  switch (status) {
    case 401:
      uni.showToast({
        title: '未授权，请重新登录',
        icon: 'none'
      })
      // 可以在这里跳转到登录页面
      break
    case 403:
      uni.showToast({
        title: '权限不足',
        icon: 'none'
      })
      break
    case 404:
      uni.showToast({
        title: '请求的资源不存在',
        icon: 'none'
      })
      break
    case 500:
      uni.showToast({
        title: '服务器内部错误',
        icon: 'none'
      })
      break
    default:
      uni.showToast({
        title: '请求失败',
        icon: 'none'
      })
  }
}

/**
 * 统一请求方法
 * @param {Object} options - 请求选项
 * @returns {Promise} - 返回 Promise
 */
export function request(options) {
  return service.request ? service.request(options) : service(options)
}

/**
 * GET 请求
 * @param {string} url - 请求地址
 * @param {Object} params - 请求参数
 * @returns {Promise} - 返回 Promise
 */
export function get(url, params) {
  return request({
    url,
    method: 'GET',
    data: params
  })
}

/**
 * POST 请求
 * @param {string} url - 请求地址
 * @param {Object} data - 请求数据
 * @returns {Promise} - 返回 Promise
 */
export function post(url, data) {
  return request({
    url,
    method: 'POST',
    data
  })
}

/**
 * PUT 请求
 * @param {string} url - 请求地址
 * @param {Object} data - 请求数据
 * @returns {Promise} - 返回 Promise
 */
export function put(url, data) {
  return request({
    url,
    method: 'PUT',
    data
  })
}

/**
 * DELETE 请求
 * @param {string} url - 请求地址
 * @param {Object} params - 请求参数
 * @returns {Promise} - 返回 Promise
 */
export function del(url, params) {
  return request({
    url,
    method: 'DELETE',
    data: params
  })
}