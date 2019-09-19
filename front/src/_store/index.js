import Vue from 'vue'
import Vuex from 'vuex'
import { userModule } from './modules/user.module'
import { workingtimeModule } from './modules/workingtime.module'
import { clockModule } from './modules/clock.module'
import { registerModule } from './modules/register.module'

Vue.use(Vuex)

const store = new Vuex.Store({
    modules: {
        userModule,
        workingtimeModule,
        clockModule,
        registerModule
    }
})

export default store