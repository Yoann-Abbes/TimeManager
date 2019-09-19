import { clockManagerService } from '../../_services/clockmanager.service'

export const clockModule = {
    namespaced: true,
    state:{
        clock: {
            status: '',
            time: '',
            boolean: false
        },
        create: {
            status: ''
        }
    },
    getters: {
        getCurrentClock: state => state.clock
    },
    mutations: {
        createLoading(state){
            state.create.status = 'loading'
        },
        createError(state){
            state.create.status = 'error'
        },
        createSuccess(state){
            state.create.status = 'success'
        },
        getLoading(state){
            state.clock.status = 'loading'
        },
        getError(state){
            state.clock.status = 'error'
        },
        getSuccess(state, payload){
            state.clock.status = 'success'
            state.clock.time = payload.data.data.time
            state.clock.boolean = payload.data.data.status
        }
    },
    actions: {
        createClock({commit, state}, {userId}){
            commit('createLoading')
            clockManagerService.createClock(userId, !state.clock.boolean).then(
                success => {
                    commit('createSuccess')
                },
                error => {
                    commit('createError')
                }
            )
        },
        getClock({commit}, {userId}){
            commit('getLoading')
            clockManagerService.getClock(userId).then(
                success => {
                    commit('getSuccess', success)
                },
                error => {
                    commit('getError')
                }
            )
        }
    }
}