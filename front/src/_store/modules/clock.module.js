import { clockManagerService } from '../../_services/clockmanager.service'
import store from "../index"

export const clockModule = {
    namespaced: true,
    state:{
        clock: {
            status: '',
            time: 0,
            current: 0,
            boolean: false,
            interval: 0
        },
        create: {
            status: ''
        }
    },
    getters: {
        getCurrentClock: state => state.clock,
        getRefreshTime: state => ((state.clock.current - state.clock.time - 7200) >= 0) ? (state.clock.current - state.clock.time - 7200) : 0,
        getBool: state => state.clock.boolean
    },
    mutations: {
        createLoading(state){
            state.create.status = 'loading'
        },
        createError(state){
            state.create.status = 'error'
        },
        createSuccess(state, payload){
            if(payload === 404){
                clearInterval(state.clock.interval)
                state.clock = {
                    status: 'success',
                    time: 0,
                    current: 0,
                    boolean: false,
                    interval: 0
                }
            }else{
                state.create.status = 'success'
                state.clock. status = 'success'
                state.clock.time = payload.data.data.time
                if (state.clock.boolean === false) {
                    state.clock.interval = setInterval(() => {
                        let dt = new Date()
                        dt.setHours(dt.getHours() + 2)
                        state.clock.current = Math.round(dt.getTime() / 1000)
                    }, 1000)
                } else {
                    clearInterval(state.clock.interval)
                    state.clock = {
                        status: 'success',
                        time: 0,
                        current: 0,
                        boolean: false,
                        interval: 0
                    }
                }
                if (Array.isArray(payload.data.data)) {
                    let dt = new Date(payload.data.data[0].time)
                    state.clock.time = Math.round(dt.getTime() / 1000)
                } else {
                    let dt = new Date(payload.data.data.time)
                    state.clock.time = Math.round(dt.getTime() / 1000)
                }
                state.clock.boolean = payload.data.data.status
            }
        },
        resetInterval(state){
            clearInterval(state.clock.interval)
            state.clock.interval = 0
            state.clock.status = 'loading'
        },
        getLoading(state){
            state.clock.status = 'loading'
        },
        getError(state){
            state.clock.status = 'error'
        },
        getSuccess(state, payload){
            if(Array.isArray(payload.data.data)){
                if(payload.data.data.length > 0){
                    let dt = new Date(payload.data.data[0].time)
                    state.clock.time = Math.round(dt.getTime() / 1000)
                    state.clock.boolean = payload.data.data[0].status
                    state.clock.interval = setInterval(() => {
                        let dt = new Date()
                        dt.setHours(dt.getHours() + 2)
                        state.clock.current = Math.round(dt.getTime() / 1000)
                        state.clock.status = 'success'
                    }, 1000)
                }else{
                    state.clock.status = 'success'
                }
            }else{
                if(Object.keys(payload.data.data).length > 0){
                    let dt = new Date(payload.data.data.time)
                    state.clock.time = Math.round(dt.getTime() / 1000)
                    state.clock.boolean = payload.data.data.status
                    state.clock.interval = setInterval(() => {
                        let dt = new Date()
                        dt.setHours(dt.getHours() + 2)
                        state.clock.current = Math.round(dt.getTime() / 1000)
                        state.clock.status = 'success'
                    }, 1000)
                }
            }
        }
    },
    actions: {
        createClock({commit, state}, {userId}){
            commit('createLoading')
            clockManagerService.createClock(userId, state.clock.boolean).then(
                success => {
                    commit('createSuccess', success)
                    store.dispatch('workingtimeModule/getWorkingTimes', {userId})
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
                    store.dispatch('workingtimeModule/getWorkingTimes', {userId})
                },
                error => {
                    commit('getError')
                }
            )
        },
        resetInterval({commit}){
            commit('resetInterval')
        }
    }
}