/**
 * 用户相关 API
 */
import { request } from '@/api/index'

/**
 * 获取用户信息
 */
export function getUserInfo() {
  return request({
    url: '/api/v1/user/info',
    method: 'GET'
  })
}

/**
 * 登录
 */
export function login(params) {
  return request({
    url: '/api/v1/user/login',
    method: 'POST',
    data: params
  })
}