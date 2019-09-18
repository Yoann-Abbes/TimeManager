import  Vue  from  'vue'
import  Vuex  from  'vuex'
import { authModule } from './modules/auth.module'
import { userModule } from './modules/user.module'
import { workingtimeModule } from './modules/workingtime.module'
import { clockModule } from './modules/clock.module'

Vue.use(Vuex)

const store = new Vuex.Store({
    modules: {
        authModule,
        userModule,
        workingtimeModule,
        clockModule
    }
})

export default store