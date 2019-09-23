import Vue from 'vue'
import Vuex from 'vuex'
import { userModule } from './modules/user.module'
import { workingtimeModule } from './modules/workingtime.module'
import { clockModule } from './modules/clock.module'
import { authModule } from './modules/auth.module'

Vue.use(Vuex)

const store = new Vuex.Store({
    modules: {
        userModule,
        workingtimeModule,
        clockModule,
        authModule
    }
})

export default store