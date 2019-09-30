import { chartManagerService } from '../../_services/chartmanager.service'

export const chartModule = {
    namespaced: true,
    state:{
        workingtimes:{
            status: '',
            data: []
        },
    },
    getters: {
        getChartWorkingtimes: state => state.workingtimes
    },
    mutations: {
        chartWorkingTimesLoading(state){
            state.workingtimes.status = 'loading'
        },
        chartWorkingTimesError(state){
            state.workingtimes.status = 'error'
        },
        chartWorkingTimesSuccess(state, payload){
            state.workingtimes.status = 'success'
            state.workingtimes.data = payload
        }
    },
    actions: {
        getAllWorkinTimes({commit, rootGetters}){
            commit('chartWorkingTimesLoading')
            const getAll = rootGetters['workingtimeModule/getWorkingTimes']
            if(getAll.status === 'error'){
                commit('chartWorkingTimesError')
            }
            if(getAll.status === 'success'){
                commit('chartWorkingTimesSuccess', getAll.data)
            }
        }
    }
}