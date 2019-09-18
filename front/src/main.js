import Vue from 'vue'
import App from './App.vue'
import store from './_store'
import router from './_helpers/router'
import VueMaterial from 'vue-material'
import { MdButton, MdContent, MdTabs } from 'vue-material/dist/components'
import moment from 'vue-moment'
import Raphael from 'raphael/raphael'
global.Raphael = Raphael

import 'vue-material/dist/vue-material.min.css'
import 'vue-material/dist/theme/default.css'
import './assets/css/styles.css'

Vue.config.productionTip = false
Vue.use(VueMaterial)
Vue.use(MdButton)
Vue.use(MdContent)
Vue.use(MdTabs)
Vue.use(moment);

new Vue({
  data:{
    user: {
      id:'',
      username:'',
      email:'',
      status: ''
    }
  },
  store,
  router,
  computed: {
    getCurrentUser(){
      return this.user
    }
  },
  methods: {
    changeUserId(id){
      this.user.id = id
    },
    changeUser(user = {}){
      if(user.id && user.username && user.email){
        this.user = {
          id: user.id,
          username: user.username,
          email: user.email,
          status: 'success'
        }
      }else{
        this.user.username = '',
        this.user.email = '',
        this.user.status = 'error'
      }
    },
    changeStatusUser(status){
      this.user.status = status
    }
  },
  mounted(){
    router.push('/')
  },
  render: h => h(App),
}).$mount('#app')
