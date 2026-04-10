import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      redirect: '/index'
    },
    {
      path: '/index',
      name: 'index',
      component: () => import('../pages/index/index.vue'),
      meta: { title: '刷刷' }
    },
    {
      path: '/find',
      name: 'find',
      component: () => import('../pages/find/index.vue'),
      meta: { title: '找片' }
    },
    {
      path: '/welfare',
      name: 'welfare',
      component: () => import('../pages/welfare/index.vue'),
      meta: { title: '福利' }
    },
    {
      path: '/mine',
      name: 'mine',
      component: () => import('../pages/mine/index.vue'),
      meta: { title: '我的' }
    }
  ]
})

export default router