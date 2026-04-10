/**
 * 剧集相关 API
 */
import { request } from '@/api/index'

/**
 * 获取剧集列表
 */
export function getDramaList(params) {
  return request({
    url: '/api/v1/dramas',
    method: 'GET',
    data: params
  })
}

/**
 * 获取剧集详情
 */
export function getDramaDetail(id) {
  return request({
    url: `/api/v1/dramas/${id}`,
    method: 'GET'
  })
}