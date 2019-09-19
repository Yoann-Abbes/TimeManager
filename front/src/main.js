import Vue from 'vue'
import App from './App.vue'
import axios from 'axios'
import router from './_helpers/router'
import VueMaterial from 'vue-material'
import { MdButton, MdContent, MdTabs } from 'vue-material/dist/components'
import moment from 'vue-moment'
import Raphael from 'raphael/raphael'
import store from './_store'

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

axios.interceptors.response.use((response) => {
    return response
}, function (error) {
    if (error.response.status === 401){
        store.dispatch('authModule/logout')
    }
    return Promise.reject(error.response)
})

new Vue({
    store,
    router,
    render: h => h(App),
}).$mount('#app')